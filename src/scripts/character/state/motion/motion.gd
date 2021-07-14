extends "res://src/scripts/state_machine/state.gd"
# Collection of important methods to handle direction and animation.

func handle_input(event):
	if event.is_action_pressed("simulate_damage"):
		emit_signal("finished", "damage")


func get_input_direction():
	var input_direction = Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	return input_direction


#更新方向
func update_look_direction(direction):
	if direction and owner.look_direction.x != direction.x and direction.x != 0:
		owner.flip_h(direction.x == -1);
	if direction and owner.look_direction != direction:
		owner.look_direction = direction
