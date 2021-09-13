extends BTLeaf

func _tick(agent: Node, blackboard: Blackboard):
	var closest_node = blackboard.get_data("ReallyCloseResource")
	var energy = blackboard.get_data("Energy")
	if closest_node != null:	
		yield(get_tree().create_timer(1, false), "timeout") # It takes one second to drain 10 energy
		if closest_node.Energy > 0:
			closest_node.Energy -= 10
			blackboard.set_data("Energy", energy + 10)
			return succeed()	
		else:
			return fail()
	
	return fail()
		
