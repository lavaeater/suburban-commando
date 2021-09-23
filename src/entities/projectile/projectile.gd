extends RigidBody
export var force = 100
export var bounce_count = 2

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Projectile_body_entered(body):
	bounce_count -= 1
	# Check if it is an enemy. Regardless, this one is being removed now
	if bounce_count <= 0:
		queue_free()
