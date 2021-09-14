extends Spatial

export (String) var Group = "Enemies" 
export (int) var MinimumSpawned = 1
export (int) var MaximumSpawned = 1
export (float) var CoolDown = 1.0
export (String) var SceneToSpawn = "res://src/entities/enemy-two/Enemy2.tscn"

onready var ActualCoolDown = CoolDown
onready var ToSpawn = load(SceneToSpawn)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ActualCoolDown -= delta
	if ActualCoolDown < 0:
		ActualCoolDown = CoolDown
		var count = get_tree().get_nodes_in_group(Group).size()
		
		if count < MinimumSpawned or count < MaximumSpawned:		 
			var newly_spawned = ToSpawn.instance()
			newly_spawned.add_to_group(Group)
			var parent = get_parent()
			remove_child(newly_spawned)
			parent.add_child(newly_spawned)
		
