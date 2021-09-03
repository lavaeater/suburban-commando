extends Spatial

var proximal_enemies = []
var active = false
onready var weapon_mount = get_node("WeaponMount")
onready var raycast = get_node("WeaponMount/RayCast")
onready var left_muzzle = get_node("WeaponMount/LeftMuzzle")
onready var right_muzzle = get_node("WeaponMount/RightMuzzle")
var randomizer = RandomNumberGenerator.new()
var cool_down = 0.1
var can_shoot = true
var flash_down = 0.05
var left = true
var flash_on = false

func _ready():
	randomizer.randomize()
	
func _physics_process(delta):
	if !can_shoot:
		cool_down -= delta
		if left and !flash_on:
			left_muzzle.visible = true
			flash_on = true
		elif !flash_on:
			right_muzzle.visible = true
			flash_on = true
		
	if flash_on:
		flash_down -= delta
		
	if flash_down < 0:
		flash_on = false
		flash_down = 0.05
		if left:
			left_muzzle.visible = false
		else:
			right_muzzle.visible = false
		left = !left
	
	if cool_down < 0.0:
		cool_down = 0.1
		can_shoot = true
		
	var closest_enemy = get_closest_enemy(proximal_enemies)
	if closest_enemy != null:
		var global_pos = weapon_mount.global_transform.origin
		var enemy_pos = closest_enemy.global_transform.origin
		var rotation_speed = 0.05
		var wtransform = weapon_mount.global_transform.looking_at(Vector3(enemy_pos.x,global_pos.y,enemy_pos.z),Vector3.UP)
		var wrotation = Quat(weapon_mount.global_transform.basis).slerp(Quat(wtransform.basis), rotation_speed)
		weapon_mount.global_transform = Transform(Basis(wrotation), weapon_mount.global_transform.origin)
		
	
func activate():
	active = true
#	get_node("BehaviorTree")

func _on_Area_body_entered(body):
	if active:
		proximal_enemies.append(body)

func _on_Area_body_exited(body):
	if active:
		proximal_enemies.erase(body)

func turn_towards_closest_enemy():
	# This needs to return RUNNING, my man
	return Task.SUCCEEDED

func is_enemy_close():
	if proximal_enemies.size() > 0:
		var close_one = get_closest_enemy(proximal_enemies)
		var dot_product = (weapon_mount.transform.origin - close_one.transform.origin).dot(weapon_mount.transform.basis.z)
		if dot_product > 0: #and dot_product < 0.5:
			return Task.SUCCEEDED
		else:
			return Task.FAILED	
		
	else:
		return Task.FAILED
		
func get_closest_enemy(enemy_list):
	if enemy_list.size() > 0:
		var closest_body = enemy_list[0]
		var distance = global_transform.origin.distance_squared_to(closest_body.global_transform.origin)
		for body in enemy_list:
			var new_distance = global_transform.origin.distance_squared_to(body.global_transform.origin)
			if new_distance < distance:
				closest_body = body
				distance = new_distance
		return closest_body
	else:
		return null

func shoot_closest_enemy():
	var closest_enemy = get_closest_enemy(proximal_enemies)
	if closest_enemy != null and can_shoot:
		can_shoot = false
		var random_angle = randomizer.randfn() # Should get us -1 to 1
		var cast_to = (closest_enemy.global_transform.origin - raycast.global_transform.origin).normalized() * 25
		cast_to = cast_to.rotated(Vector3.UP, deg2rad(random_angle))
		raycast.cast_to = cast_to
		if raycast.is_colliding():
			var collidee = raycast.get_collider()
			var bentity = collidee.get_node("BaseEntity")
			if bentity != null:
				# this is indeed an enemy
				bentity.take_damage(randomizer.randi_range(10, 25))
	return Task.SUCCEEDED 
		
		
