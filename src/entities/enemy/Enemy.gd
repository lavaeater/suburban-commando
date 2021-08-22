extends KinematicBody

var gravity = Vector3.DOWN * 12
var speed = 10
var jump_speed = 6
var velocity = Vector3()
var direction = Vector3()
var spin = .1
var jump = false
var look_at_target = Vector3()
onready var muzzle_flash = $blasterA.get_node("MuzzleFlash")
onready var rayBlaster = $blasterA.get_node("RayCast")
var fire = false
var can_fire = true
var has_fired = false

var rof = 200.0 # per minute
var rof_cool_down = 1.0 / (rof / 60.0)
var cool_down = rof_cool_down
var flash_cool_down = rof_cool_down / 3.0
var muzzle_cool = flash_cool_down
var impact_thingie = preload("res://src/fx/anime_explosion.tscn")
var last_impact_point = Vector3()
var last_explosion_position = Vector3()

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector3.UP)
	if jump and is_on_floor():
		velocity.y = jump_speed
	look_at(look_at_target, Vector3.UP)
	handle_shots(delta)

func handle_shots(delta):
	if fire and can_fire:
		has_fired = true
		muzzle_flash.visible = true
		if rayBlaster.is_colliding():
			last_impact_point = rayBlaster.get_collision_point()
			var anime_explosion = impact_thingie.instance()
			get_parent().add_child(anime_explosion)
			anime_explosion.start(last_impact_point)
			anime_explosion.global_transform.origin = last_impact_point
			last_explosion_position = anime_explosion.global_transform.origin
		

	if has_fired:
		can_fire = false
		cool_down -= delta
		
	if has_fired and muzzle_cool > 0:
		muzzle_cool -= delta

	if muzzle_cool <= 0:
		muzzle_cool = flash_cool_down
		muzzle_flash.visible = false

	
	if cool_down <= 0:
		cool_down = rof_cool_down
		can_fire = true
		has_fired = false

func get_input():
	velocity.x = 0
	velocity.z = 0
	direction.x = 0
	direction.z = 0
	handle_movement()
	handle_jumping()
	handle_shooting()
	
func handle_shooting():
	fire = false
	if Input.is_action_pressed("fire_primary"):
		fire = true

func handle_movement():
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

func handle_jumping():
	jump = false
	if Input.is_action_just_pressed("jump"):
		jump = true

func _on_CameraPivot_look_at_target(position):
	look_at_target = position


func _on_BaseEntity_death_occurred():
	queue_free()


func _on_BaseEntity_took_damange():
	pass # What happens when taking damage?
