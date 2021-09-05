extends KinematicBody

var gravity = Vector3.DOWN * 12
var speed = 60
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
onready var place_point = $PlacePoint

func _physics_process(delta):
	velocity += gravity
	get_input()
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.slide(collision.normal)
	
	if jump and is_on_floor():
		velocity.y = jump_speed
	look_at(look_at_target, Vector3.UP)
	if node_to_build != null:
		node_to_build.global_transform.origin.x = place_point.global_transform.origin.x
		node_to_build.global_transform.origin.z = place_point.global_transform.origin.z
		node_to_build.global_transform.origin.y = 0
		node_to_build.global_transform.basis.x = Vector3.RIGHT
		node_to_build.global_transform.basis.y = Vector3.UP
		node_to_build.global_transform.basis.z = Vector3.BACK
	handle_shots(delta)

func is_moving():
	return velocity != Vector3.ZERO

func handle_shots(delta):
	if fire and can_fire:
		has_fired = true
		muzzle_flash.visible = true
		if rayBlaster.is_colliding():
			var collider = rayBlaster.get_collider()
			var entity = collider.get_node("BaseEntity")
			if entity != null:
				entity.take_damage(30)
				
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
	handle_jumping()
	handle_shooting()
	handle_building()
	
var build_mode = false
var node_to_build = null
func handle_building():
	var can_release = true
	if !build_mode and Input.is_action_just_released("build"):
		build_mode = true
		can_release = false
	if build_mode and node_to_build == null:
		node_to_build = load("res://src/entities/towers/Tower1.tscn").instance()
		node_to_build.transform.origin = $PlacePoint.transform.origin
		add_child(node_to_build) #We'll move it to the scene later!
	if build_mode and can_release and Input.is_action_just_released("build"):
		reparent(node_to_build, self.get_parent())
		node_to_build.activate()
		build_mode = false
		node_to_build = null
	
func reparent(child: Node, new_parent: Node):
	var global_position = child.global_transform
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)
	child.global_transform = global_position
	
func handle_shooting():
	fire = false
	if Input.is_action_pressed("fire_primary"):
		fire = true

func handle_jumping():
	jump = false
	if Input.is_action_just_pressed("jump"):
		jump = true

func _on_CameraPivot_look_at_target(position):
	look_at_target = position

func _on_BaseEntity_took_damange():
	pass # Player took damage


func _on_BaseEntity_death_occurred():
	pass # Player died
