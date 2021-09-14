extends BTLeaf
class_name MoveTowardsNode, "res://addons/behavior_tree/icons/btleaf.svg"

export (String) var NodeKey = "ClosestResource"
export (String) var SpeedKey = "Speed"
export (float) var TargetDistance = 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var target_node = blackboard.get_data(NodeKey)
	var delta = blackboard.process_delta
	if target_node != null:
		if agent.global_transform.origin.distance_squared_to(target_node.global_transform.origin) < TargetDistance:
			return fail()
		var speed = blackboard.get_data(SpeedKey)
		agent.global_transform.origin = agent.global_transform.origin.move_toward(target_node.global_transform.origin, speed * delta)
		return succeed()
	
	return fail()
