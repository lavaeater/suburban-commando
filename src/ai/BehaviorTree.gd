extends Task

class_name BehaviorTree

var current_task_running = ""

func _ready():
	tree = self
	.start()
	status = RUNNING
	
func _process(_delta):
	run()
	
var current_child = 0

func run():
	get_child(current_child).run()
	running()

func move_to_next_child():
	current_child += 1
	if current_child >= get_child_count():
		current_child = 0

func child_success():
	move_to_next_child()

func child_fail():
	move_to_next_child()

func cancel():
	current_child = 0
	.cancel()

func start():
	current_child = 0
	.start()

