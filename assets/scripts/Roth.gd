extends KinematicBody


# How fast the player moves in meters per second.
export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75

onready var animPlayer = get_node("RootNode/AnimationPlayer")
onready var camera = get_parent().get_node("Camera")

var velocity = Vector3.ZERO
var rotationAxisForMovement = Vector3(0,1,0)
var elapsed = 0
const ray_length = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	# We create a local variable to store the input direction.
	var direction = Vector3.ZERO
	elapsed += delta

	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("down"):
		direction.z += 1
	if Input.is_action_pressed("up"):
		direction.z -= 1
		
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		direction = direction.rotated(rotationAxisForMovement, deg2rad(45))				
		
		animPlayer.current_animation = "walking"
	else:
		animPlayer.current_animation = "aim_idle"
			
	
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	# Vertical velocity
	velocity.y -= fall_acceleration * delta
	# Moving the character
	velocity = move_and_slide(velocity, Vector3.UP)
