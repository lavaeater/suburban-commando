extends Spatial

export (NodePath) var target

func _ready():
	pass # Replace with function body.


func _process(delta):
	if target:
		global_transform.origin = get_node(target).global_transform.origin
