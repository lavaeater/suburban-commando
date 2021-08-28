extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
		
func start(position):
	global_transform.origin = position
	$AnimationPlayer.play("explode")

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
