extends "res://src/scripts/state_machine/state_machine.gd"

onready var idle = $Idle
onready var move = $Move
onready var jump = $Jump
onready var damage = $Damage
onready var attack = $Attack
onready var down = $Down

func _ready():
	pass
	states_map = {
		"idle": idle,
		"move": move,
		"jump": jump,
		"damage": damage,
		"attack": attack,
		"down":down,
	}


func _change_state(state_name):
	pass
#	if not _active:
#		return
#	if state_name in ["damage", "jump", "attack"]:
#		states_stack.push_front(states_map[state_name])
#	if state_name == "jump" and current_state == move:
#		jump.initialize(move.speed, move.velocity)
#	._change_state(state_name)


#func _unhandled_input(event):
#	# Here we only handle input that can interrupt states, attacking in this case,
#	# otherwise we let the state node handle it.
#	if event.is_action_pressed("attack"):
#		if current_state in [attack, stagger]:
#			return
#		_change_state("attack")
#		return
#	current_state.handle_input(event)
