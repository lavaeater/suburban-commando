extends BTLeaf


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (String) var ResourceName = "ClosestResource"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var closest_resource = blackboard.get_data(ResourceName)
	var delta = blackboard.process_delta
	if closest_resource != null:
		var speed = blackboard.get_data("Speed")
		agent.global_transform.origin = agent.global_transform.origin.move_toward(closest_resource.global_transform.origin, speed * delta)
		if agent.global_transform.origin.distance_squared_to(closest_resource.global_transform.origin) < 5:
			return succeed()
	
	return fail()
