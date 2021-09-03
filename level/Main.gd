extends Spatial


onready var enemy = get_node("Enemy")

onready var floor_width = $Floor.get_node("MeshInstance").mesh.size.x
onready var floor_depth = $Floor.get_node("MeshInstance").mesh.size.y
onready var floor_center = $Floor.global_transform.origin

onready var node_ref = weakref(get_node("Enemy"))

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

func get_enemy():
	return node_ref.get_ref()

func get_player_velocity():
	return $Player.velocity

func get_player_direction():
	return $Player.direction

func get_player_position():
	return $Player.global_transform.origin

func get_enemy_position():
	var t = Vector3.ZERO
	var enemy = get_enemy()
	if enemy != null:	
		t = enemy.global_transform.origin
	return t
	
func get_target_vector():
	var t = Vector3.ZERO
	var enemy = get_enemy()
	if enemy != null:
		t = enemy.target_vector
	return t
	
func get_current_enemy_action():
	name = "Enemy Action Pending"
	var enemy = get_enemy()
	if enemy != null:
		var behavior_tree = enemy.get_node("Enemy/EnemyBehavior")
		if behavior_tree != null and behavior_tree.tree != null:
			name = "Enemy Action: " + behavior_tree.tree.current_task_running
			return name

