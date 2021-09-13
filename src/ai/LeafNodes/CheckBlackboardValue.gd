extends BTConditional
class_name CheckBlackboardValue, "res://addons/behavior_tree/icons/btleaf.svg"

export var PropertyToCheck = "Energy"
export var PropertyValue = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _pre_tick(agent: Node, blackboard: Blackboard) -> void:
	var prop_value = blackboard.get_data(PropertyToCheck)
	if prop_value < PropertyValue:
		verified = true
	else:
		verified = false
		
