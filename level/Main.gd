extends Spatial


onready var enemy = get_node("Enemy")

onready var floor_width = 200.0
onready var floor_depth = 200.0
onready var floor_center = Vector3(0,0,0)

onready var node_ref = weakref(get_node("Enemy"))

# Called when the node enters the scene tree for the first time.
func _ready():
	var overlay = load("res://src/ui/DebugOverlay.tscn").instance()
	overlay.add_stat_var("Camera.Near Z/X", get_node("CameraPivot/Camera"), "near")
	overlay.add_stat_var("Camera.Far c/V", get_node("CameraPivot/Camera"), "far")
	overlay.add_stat_var("Camera.Size O/P", get_node("CameraPivot/Camera"), "size")
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

