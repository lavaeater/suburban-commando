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
# A list for players inside the detection area - these aren't necessarily players the 
# enemy entity actually has noticed
var proximal_players = []

func _ready():
	random.randomize()

func _physics_process(delta):
#	velocity += gravity * delta
	
func _on_BaseEntity_death_occurred():
	queue_free()

func _on_BaseEntity_took_damange():
	pass # What happens when taking damage?
	
func _on_LongRangeSensor_body_entered(body):
	player_is_in = true
	body_that_is_currently_in = body

func _on_LongRangeSensor_body_exited(body):
	player_is_in = false
	body_that_is_currently_in = null

func _on_ActionTimer_timeout():
	if looking_for_player_status == Task.RUNNING:
		looking_for_player_status = Task.FAILED
		













	


