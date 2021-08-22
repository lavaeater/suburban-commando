extends Node

export var health = 100
var dead = false
signal death_occurred
signal took_damange

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func take_damage(damage):
	health -= damage
	emit_signal("took_damange")
	if health < 0:
		dead = true
		emit_signal("death_occurred")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
