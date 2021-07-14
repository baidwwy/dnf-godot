extends "res://src/scripts/monster/monster_state/on_ground/Monster_on_ground.gd"

func enter():
	owner.get_node("AnimationPlayer").play("stay")


#func handle_input(event):
#	return .handle_input(event)


func update(_delta):
	pass
#	var input_direction = get_input_direction()
#	if input_direction:
#		emit_signal("finished", "move")
