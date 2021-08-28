extends Spatial


onready var enemy = get_node("Enemy")
onready var behavior_tree = get_node("Enemy/EnemyBehavior")

onready var floor_width = $Floor.get_node("MeshInstance").mesh.size.x
onready var floor_depth = $Floor.get_node("MeshInstance").mesh.size.y
onready var floor_center = $Floor.global_transform.origin

# Called when the node enters the scene tree for the first time.
func _ready():
	var overlay = load("res://src/ui/DebugOverlay.tscn").instance()
	overlay.add_stat_method("Player position", self, "get_player_position")
	overlay.add_stat_method("Player velocity", self, "get_player_velocity")
	overlay.add_stat_method("Player direction", self, "get_player_direction")
	overlay.add_stat_method("Current Enemy Action", self, "get_current_enemy_action")
	overlay.add_stat_method("Enemy position", self, "get_enemy_position")
	overlay.add_stat_method("Enemy Target Position", self, "get_target_vector")
	add_child(overlay)

func get_player_velocity():
	return $Player.velocity

func get_player_direction():
	return $Player.direction

func get_player_position():
	return $Player.global_transform.origin

func get_enemy_position():
	return enemy.global_transform.origin

func get_target_vector():
	return enemy.target_vector
	
func get_current_enemy_action():
	name = "Enemy Action Pending"
	if behavior_tree != null and behavior_tree.tree != null:
		name = "Enemy Action: " + behavior_tree.tree.current_task_running
	return name

