extends KinematicBody

var gravity = Vector3.DOWN * 12
var speed = 10
var jump_speed = 6
var velocity = Vector3()
var direction = Vector3()
var spin = .1
var jump = false
var look_at_target = Vector3()

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector3.UP)
	if jump and is_on_floor():
		velocity.y = jump_speed
	look_at(look_at_target, Vector3.UP)

func get_input():
	velocity.x = 0
	velocity.z = 0
	direction.x = 0
	direction.z = 0
	
	if Input.is_action_pressed("move_forward"):
		direction.z -= speed 
	if Input.is_action_pressed("move_back"):
		direction.z += speed
	if Input.is_action_pressed("strafe_right"):
		direction.x += speed
	if Input.is_action_pressed("strafe_left"):
		direction.x -= speed
	direction = direction.rotated(Vector3.UP, PI / 4)
	velocity.x = direction.x
	velocity.z = direction.z
	jump = false
	if Input.is_action_just_pressed("jump"):
		jump = true

func _on_CameraPivot_look_at_target(position):
	look_at_target = position
