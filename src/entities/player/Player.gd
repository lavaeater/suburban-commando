extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var gravity = Vector3.DOWN * 12
var speed = 4
var jump_speed = 6
var velocity = Vector3()
var spin = .1
var jump = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	velocity += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector3.UP)
	if jump and is_on_floor():
		velocity.y = jump_speed

func get_input():
	var vy = velocity.y
	velocity = Vector3()
	if Input.is_action_pressed("move_forward"):
		velocity += -transform.basis.z * speed 
	if Input.is_action_pressed("move_back"):
		velocity += transform.basis.z * speed
	if Input.is_action_pressed("strafe_right"):
		velocity += transform.basis.x * speed
	if Input.is_action_pressed("strafe_left"):
		velocity -= -transform.basis.x * speed
	velocity.y = vy
	jump = false
	if Input.is_action_just_pressed("jump"):
		jump = true

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-lerp(0, spin, event.relative.x/10))
