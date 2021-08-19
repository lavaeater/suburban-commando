extends Spatial

export (NodePath) var target
export var ray_length = 100

func _ready():
	pass # Replace with function body.


func _process(delta):
	if target:
		global_transform.origin = get_node(target).global_transform.origin

func _physics_process(delta):
	if target:
		var from = get_node("Camera").project_ray_origin(get_viewport().get_mouse_position())
		var to = from + get_node("Camera").project_ray_normal(get_viewport().get_mouse_position()) * ray_length
		get_node("TargetBall").transform.origin = to
#		get_node(target).look_at(to, Vector3.UP)
