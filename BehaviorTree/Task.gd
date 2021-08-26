extends Node

class_name Task

# States
enum {
	FRESH,
	RUNNING,
	FAILED,
	SUCCEEDED,
	CANCELLED
}

var control = null
var tree = null
# var guard = null - look into implementing guards, maan.
var status = FRESH

export (NodePath) var agent_path # Blackboard, agent, whatever. Used for leaf tasks.

# Final methods
func running():
	status = RUNNING
	if control != null:
		control.child_running()

func success():
	status = SUCCEEDED
	if control != null:
		control.child_success()

func fail():
	status = FAILED
	if control != null:
		control.child_fail()

func cancel():
	if status == RUNNING:
		status = CANCELLED
		# Cancel child tasks
		for child in get_children():
			child.cancel()

# Abstract methods
func run():
	tree.current_task_running = self.get_name()

func child_success():
	success()

func child_fail():
	fail()

func child_running():
	running()

# Non-final non-abstact methods
func start():
	status = FRESH
	for child in get_children():
		child.control = self
		child.tree = self.tree
		child.start()

func reset():
	cancel()
	status = FRESH
