extends Sequence

export (NodePath) var agent_path # Blackboard, agent, whatever. Used for leaf tasks.

func _ready():
	tree = self
	.start()
	status = RUNNING
	
func _process(_delta):
	.run()

func child_success():
	current_child += 1
	if current_child >= get_child_count():
		current_child = 0

func child_fail():
	current_child = 0
