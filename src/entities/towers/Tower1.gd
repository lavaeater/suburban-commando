extends Spatial

var proximal_enemies = []
var close_enemies = []
var active = false
onready var weapon_mount = get_node("WeaponMount")
onready var raycast = get_node("WeaponMount/RayCast")
var randomizer = RandomNumberGenerator.new()
var cool_down = 0.1
var can_shoot = true

func _ready():
	randomizer.randomize()
	
func _physics_process(delta):
	if !can_shoot:
		cool_down -= delta
	if cool_down < 0.0:
		cool_down = 0.1
		can_shoot = true
		
	var closest_enemy = get_closest_enemy(proximal_enemies)
	if closest_enemy != null:
		var global_pos = weapon_mount.global_transform.origin
		var enemy_pos = closest_enemy.global_transform.origin
		var rotation_speed = 0.1
		var wtransform = weapon_mount.global_transform.looking_at(Vector3(enemy_pos.x,global_pos.y,enemy_pos.z),Vector3.UP)
		var wrotation = Quat(weapon_mount.global_transform.basis).slerp(Quat(wtransform.basis), rotation_speed)
		weapon_mount.global_transform = Transform(Basis(wrotation), weapon_mount.global_transform.origin)
		
	
func activate():
	active = true
#	get_node("BehaviorTree")

func _on_Area_body_entered(body, sensor):
	if active:
		if sensor == "proximity":
			proximal_enemies.append(body)
		if sensor == "aim":
			close_enemies.append(body)

func _on_Area_body_exited(body, sensor):
	if active:
		if sensor == "proximity":
			proximal_enemies.erase(body)
		if sensor == "aim":
			close_enemies.erase(body)

func turn_towards_closest_enemy():
	# This needs to return RUNNING, my man
	return Task.SUCCEEDED

func is_enemy_close():
	if close_enemies.size() > 0:
		return Task.SUCCEEDED
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
	var closest_enemy = get_closest_enemy(close_enemies)
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
		
		
