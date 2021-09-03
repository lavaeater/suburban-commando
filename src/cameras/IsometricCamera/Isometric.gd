extends Spatial

export (NodePath) var target
export var ray_length = 100
onready var camera = get_node("Camera")
signal look_at_target

func _ready():
	pass # Replace with function body.

func _process(delta):
	if target:
		global_transform.origin = get_node(target).global_transform.origin

func _physics_process(delta):
	var space_state = get_world().direct_space_state
	var from = camera.project_ray_origin(get_viewport().get_mouse_position())
	var to = from + camera.project_ray_normal(get_viewport().get_mouse_position()) * ray_length
	
	var intersection = space_state.intersect_ray(from, to)
	if not intersection.empty():
		emit_signal("look_at_target", intersection.position)
		
	handle_input()
		
func handle_input():
	if Input.is_action_pressed("cam_near_in"):
		camera.near -= camera.near / 10
	if Input.is_action_pressed("cam_near_out"):
		camera.near += camera.near / 10
	if Input.is_action_pressed("cam_far_in"):
		camera.far -= camera.far / 10
	if Input.is_action_pressed("cam_far_out"):
		camera.far += camera.far / 10
	if Input.is_action_pressed("cam_size_in"):
		camera.size -= camera.size / 10
	if Input.is_action_pressed("cam_size_out"):
		camera.size += camera.size / 10		
		
