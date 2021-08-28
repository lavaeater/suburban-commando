extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var randomizer = RandomNumberGenerator.new()
var format_string = "res://src/entities/map/houses/House%s.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	randomizer.randomize()
	var houseNumber = randomizer.randi_range(1, 21)
	var houseToLoad = format_string % houseNumber
	var actualHouse = load(houseToLoad).instance()
	var currentHouse = get_node("house_type01")
	actualHouse.transform.origin = currentHouse.transform.origin
	actualHouse.scale = actualHouse.scale * 6
	currentHouse.queue_free()
	add_child(actualHouse)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
