extends BTConditional

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _pre_tick(agent: Node, blackboard: Blackboard) -> void:
	var resources = get_tree().get_nodes_in_group(blackboard.get_data("ResourceGroup"))
	var closest_resource = null
	var distance = 10000.0
	for resource in resources:
		var new_dist = agent.global_transform.origin.distance_squared_to(resource.global_transform.origin)
		if new_dist < distance:
			distance = new_dist
			closest_resource = resource
	var res_distance = blackboard.get_data("ResourceDistance")
	if distance < res_distance:
		blackboard.set_data("ClosestResource", closest_resource)
		verified = true
	else:
		blackboard.set_data("ClosestResource", null)
		verified = false
		
