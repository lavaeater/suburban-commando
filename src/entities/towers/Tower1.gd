extends Spatial

var proximal_enemies = []
var close_enemies = []
var active = false

func _ready():
	pass # Replace with function body.
	
func activate():
	active = true
	get_node("BehaviorTree")

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
	pass

func is_enemy_close():
	if close_enemies.size > 0:
		return Task.SUCCEEDED
	else:
		return Task.FAILED
		

func shoot_closest_enemy():
	if close_enemies.size > 0:
		# Checks if we have enemies in the close_enemies array. 
		var closest_body = close_enemies[0]
		var distance = global_transform.origin.distance_to(closest_body.global_transform.origin)
		for body in close_enemies:
			var new_distance = global_transform.origin.distance_to(body.global_transform.origin)
			if new_distance < distance:
				closest_body = body
				distance = new_distance
		# So, what does shooting really mean?
		# And what does success mean? There should 
	return Task.SUCCEEDED 
		
		
