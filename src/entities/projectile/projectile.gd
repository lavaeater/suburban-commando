extends RigidBody
export var force = 100

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	apply_impulse(Vector3.ZERO, Vector3(0, 0, 10))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
