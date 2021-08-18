extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var gravity = Vector3.DOWN * 12
var speed = 4
var jump_speed = 6
var velocity = Vector3()


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

func get_input():
	velocity.x = 0
	velocity.z = 0
	if Input.is_action_pressed("move_forward"):
		velocity.z -= speed
	if Input.is_action_pressed("move_back"):
		velocity.z += speed
	if Input.is_action_pressed("strafe_right"):
		velocity.x += speed
	if Input.is_action_pressed("strafe_left"):
		velocity.x -= speed
