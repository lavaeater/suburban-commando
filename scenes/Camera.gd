extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var offset = Vector3(50,50,50)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

onready var player = get_parent().get_node("Roth")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_transform.origin = player.global_transform.translated(offset).origin
	look_at(player.global_transform.origin, Vector3(0,1,0))
