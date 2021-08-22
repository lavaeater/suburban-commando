extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var overlay = load("res://src/ui/DebugOverlay.tscn").instance()
	overlay.add_stat_method("Player position", self, "get_player_position")
	overlay.add_stat_var("Base cooldown", $Player, "rof_cool_down")
	overlay.add_stat_var("Fire cooldown", $Player, "cool_down")
	overlay.add_stat_var("Firing", $Player, "fire")
	overlay.add_stat_var("Can Fire", $Player, "can_fire")
	overlay.add_stat_var("Has Fired", $Player, "has_fired")
	overlay.add_stat_method("Collsion point", self, "get_collision_point")
	overlay.add_stat_method("Last Impact", self, "get_last_impact")
	overlay.add_stat_method("Last Explosion", self, "get_last_explosion")
	overlay.add_stat_method("Is Colliding", self, "get_is_colliding")
	add_child(overlay)

func get_is_colliding():
	return $Player.get_node("blasterA/RayCast").is_colliding()

func get_last_explosion():
	return $Player.last_explosion_position

func get_last_impact():
	return $Player.last_impact_point

func get_collision_point():
	return $Player.rayBlaster.get_collision_point()

func get_player_position():
	return $Player.transform.origin

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
