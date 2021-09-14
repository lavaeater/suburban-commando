extends BTLeaf

export (String) var BlackboardProperty = "PlayerToAttack"
export (int) var MinDamage = 5
export (int) var MaxDamage = 15
export (float) var CoolDown = 0.5

onready var ActualCooldown = CoolDown

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var randomizer = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomizer.randomize()

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	ActualCooldown -= blackboard.process_delta
	if ActualCooldown < 0:
		ActualCooldown = CoolDown
		var player = blackboard.get_data(BlackboardProperty)
		if player != null:
			var damage = randomizer.randi_range(MinDamage, MaxDamage)
			player.get_node("BaseEntity").take_damage(damage)
		else:
			return fail()
	return succeed()
