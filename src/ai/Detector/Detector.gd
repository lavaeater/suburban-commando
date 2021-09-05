extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var radius = 25.0 
var bodies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("CollisionShape").shape.radius = radius


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func get_closest_body():
	if bodies.size() > 0:
		var closest_body = bodies[0]
		var distance = global_transform.origin.distance_squared_to(closest_body.global_transform.origin)
		for body in bodies:
			var new_distance = global_transform.origin.distance_squared_to(body.global_transform.origin)
			if new_distance < distance:
				closest_body = body
				distance = new_distance
		return closest_body
	else:
		return null

func anyone():
	return bodies.size() > 0

func _on_Detector_body_entered(body):
	bodies.append(body)


func _on_Detector_body_exited(body):
	bodies.erase(body)
