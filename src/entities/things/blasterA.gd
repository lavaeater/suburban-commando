extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var ray_cast = $RayCast
onready var hit_point = $HitPoint
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if ray_cast.is_colliding():
		hit_point.global_transform.origin = ray_cast.get_collision_point()
