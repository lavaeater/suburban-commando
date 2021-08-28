extends KinematicBody

var gravity = Vector3.DOWN * 12
var speed = 15
var jump_speed = 6
var velocity = Vector3()
var spin = .1
var jump = false
var look_at_target = Vector3()

# Called when the node enters the scene tree for the first time.
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
	var vy = velocity.y
	velocity = Vector3()
	
	
	if Input.is_action_pressed("move_forward"):
		velocity.z = -speed# rotatedBasis.z * speed 
	if Input.is_action_pressed("move_back"):
		velocity.z = speed#-rotatedBasis.z * speed
	if Input.is_action_pressed("strafe_right"):
		velocity.x = speed #-rotatedBasis.x * speed
	if Input.is_action_pressed("strafe_left"):
		velocity.x = -speed #rotatedBasis.x * speed
		
	velocity.y = vy
	
	velocity = velocity.rotated(Vector3.UP, deg2rad(30))
	jump = false
	if Input.is_action_just_pressed("jump"):
		jump = true


func _on_CameraPivot_look_at_target(position):
	pass
	#look_at_target = position

