extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var proximal_enemies = []
var close_enemies


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body, sensor):
	if sensor == "proximity":
		proximal_enemies.append(body)
	if sensor == "aim":
		close_enemies.append(body)

func _on_Area_body_exited(body, sensor):
	if sensor == "proximity":
		proximal_enemies.erase(body)
	if sensor == "aim":
		close_enemies.erase(body)
