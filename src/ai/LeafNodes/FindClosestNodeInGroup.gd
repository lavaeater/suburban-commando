extends BTConditional
class_name FindClosestNodeInGroup, "res://addons/behavior_tree/icons/btleaf.svg"

export var GroupName = "Resource"
export var DetectionDistance = 100.0
export var BlackBoardKey = "ClosestResource"
export var CheckProperty = true
export var PropertyToCheck = "Energy"
export var PropertyValue = 80

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _pre_tick(agent: Node, blackboard: Blackboard) -> void:
	var resources = get_tree().get_nodes_in_group(GroupName)
	var closest_resource = null
	var distance = 100000.0
	for resource in resources:
		var property_level = resource.get(PropertyToCheck)
		var new_dist = agent.global_transform.origin.distance_squared_to(resource.global_transform.origin)
		var check_prop = !CheckProperty or property_level > PropertyValue
		if new_dist < distance and check_prop:
			distance = new_dist
			closest_resource = resource
	if distance < DetectionDistance:
		blackboard.set_data(BlackBoardKey, closest_resource)
		verified = true
	else:
		blackboard.set_data(BlackBoardKey, null)
		verified = false
		
