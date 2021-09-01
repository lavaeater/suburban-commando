extends Spatial

var proximal_enemies = []
var close_enemies = []
var active = false

func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	var closest_enemy = get_closest_enemy(proximal_enemies)
	if closest_enemy != null:
		var global_pos = $WeaponMount.global_transform.origin
		var enemy_pos = closest_enemy.global_transform.origin
		var rotation_speed = 0.1
		var wtransform = $WeaponMount.global_transform.looking_at(Vector3(enemy_pos.x,global_pos.y,enemy_pos.z),Vector3.UP)
		var wrotation = Quat($WeaponMount.global_transform.basis).slerp(Quat(wtransform.basis), rotation_speed)
		$WeaponMount.global_transform = Transform(Basis(wrotation), $WeaponMount.global_transform.origin)
		
	
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
	if closest_enemy != null:
		pass
	return Task.SUCCEEDED 
		
		
