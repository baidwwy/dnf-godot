extends "res://src/scripts/state_machine/state.gd"

#func handle_input(event):
#	if event.is_action_pressed("simulate_damage"):
#		emit_signal("finished", "stagger")


#func get_input_direction():
#	var input_direction = Vector2(
#			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
#			Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
#	)
#	return input_direction


#func update_look_direction(direction):
#	if direction and owner.look_direction != direction:
#		owner.look_direction = direction

#判断方向
func get_direction() -> bool:
	var value:bool = false;
	owner.get_node("Character").global_position;
	var player_position:Vector2 # = owner.get_node("Character").global_position;
	var owner_position = owner.global_position;
#	if player_position.x < owner_position.x:
#		value = true;
#	else:
#		value = false;
	return value;
