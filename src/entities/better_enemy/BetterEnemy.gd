extends KinematicBody

var gravity = Vector3.DOWN * 12
var speed = 2
var jump_speed = 6
var velocity = Vector3()
var direction = Vector3()
var spin = .1
var jump = false
var look_at_target = Vector3()
onready var muzzle_flash = $blasterA.get_node("MuzzleFlash")
onready var rayBlaster = $blasterA.get_node("RayCast")
onready var action_timer = $ActionTimer
onready var root = get_parent()

var fire = false
var can_fire = true
var has_fired = false

var rof = 200.0 # per minute
var rof_cool_down = 1.0 / (rof / 60.0)
var cool_down = rof_cool_down
var flash_cool_down = rof_cool_down / 3.0
var muzzle_cool = flash_cool_down
var impact_thingie = preload("res://src/fx/anime_explosion.tscn")
var last_impact_point = Vector3()
var last_explosion_position = Vector3()

var target_vector = Vector3() # if this is zero, we don't move, ok?

var looking_for_player_status = Task.FRESH
var move_towards_status = Task.FRESH
var player_is_in = false
var body_that_is_currently_in = null

var random = RandomNumberGenerator.new()

### NEW AND EXCITING VARS ###
onready var detector = get_node("Detector")
var found_players = []
var in_fov = []

func IsAnyPlayerInFieldOfView():
	in_fov = null
	for player in found_players:
		var dot_product = (transform.origin - player.transform.origin).dot(transform.basis.z)
		if dot_product > 0: #and dot_product < 0.5:
			in_fov.append(player)
		else:
			in_fov.erase(player)
	if in_fov.size() > 0:
		return Task.SUCCEEDED
	else:
		return Task.FAILED


## WILL RETURN SUCCESS WHEN DOT PRODUCT IS LARGER THAN 0
func TurnTowardsClosest():
	var closest_player = get_closest_body()
	
	if(closest_player != null):
		var global_pos = global_transform.origin
		var enemy_pos = closest_player.global_transform.origin
		var rotation_speed = 0.05
		var wtransform = global_transform.looking_at(Vector3(enemy_pos.x,global_pos.y,enemy_pos.z),Vector3.UP)
		var wrotation = Quat(global_transform.basis).slerp(Quat(wtransform.basis), rotation_speed)
		global_transform = Transform(Basis(wrotation), global_transform.origin)
		var dot_product = (transform.origin - closest_player.transform.origin).dot(transform.basis.z)
		if dot_product > 0: #and dot_product < 0.5:
			return Task.SUCCEEDED
		else:
			return Task.RUNNING
	else:
		return Task.FAILED

func get_closest_body():
	if found_players.size() > 0:
		var closest_body = found_players[0]
		var distance = global_transform.origin.distance_squared_to(closest_body.global_transform.origin)
		for body in found_players:
			var new_distance = global_transform.origin.distance_squared_to(body.global_transform.origin)
			if new_distance < distance:
				closest_body = body
				distance = new_distance
		return closest_body
	else:
		return null


# This method returns success if the detected players array has any items in it
# 
func HasFoundAPlayer():
	if found_players.size() > 0:
		return Task.SUCCEEDED
	else:
		return Task.FAILED

# This method will simply loop over the detectors bodies and check if they are
# indeed moving
func ScanForPlayer():
	for player in detector.bodies:
		if player.is_moving():
			found_players.append(player)
	if found_players.size() > 0:
		return Task.SUCCEEDED
	else:
		return Task.FAILED


func _ready():
	random.randomize()

func _physics_process(delta):
	velocity += gravity * delta
	
func _on_BaseEntity_death_occurred():
	queue_free()

func _on_BaseEntity_took_damange():
	pass # What happens when taking damage?

func _on_ActionTimer_timeout():
	if looking_for_player_status == Task.RUNNING:
		looking_for_player_status = Task.FAILED
		








	


