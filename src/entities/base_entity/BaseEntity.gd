extends Node

export var health = 100
var dead = false
signal death_occurred
signal took_damange
export (NodePath) var Blackboard
export (String) var HealthProperty

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func take_damage(damage):
	if Blackboard != null:
		var blackboard = get_node(Blackboard)
		if blackboard != null:
			health = blackboard.get_data(HealthProperty)
			health -= damage
			blackboard.set_data(HealthProperty, health)
	else:
		health -= damage

	emit_signal("took_damange")
	if health < 0:
		dead = true
		emit_signal("death_occurred")
