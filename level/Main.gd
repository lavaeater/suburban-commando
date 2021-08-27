extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var enemy = $Enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	var overlay = load("res://src/ui/DebugOverlay.tscn").instance()
	overlay.add_stat_method("Player position", self, "get_player_position")
	overlay.add_stat_method("Current Enemy Action", self, "get_current_enemy_action")
	overlay.add_stat_method("Enemy position", self, "get_enemy_position")
	overlay.add_stat_method("Enemy Target Position", self, "get_target_vector")
	add_child(overlay)

func get_player_position():
	return $Player.global_transform.origin

func get_enemy_position():
	return enemy.global_transform.origin

func get_target_vector():
	return enemy.target_vector
	
func get_current_enemy_action():
	name = "Enemy Action Pending"
	if enemy != null
		var node = enemy.get_node("EnemyBehavior")
		if node.tree != null:
			name = "Enemy Action: " + node.tree.current_task_running
	return name
	
