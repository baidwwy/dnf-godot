extends "res://src/scripts/state_machine/state.gd"
# The stagger state end with the stagger animation from the AnimationPlayer.
# The animation only affects the Body Sprite's modulate property so it
# could stack with other animations if we had two AnimationPlayer nodes.

func enter():
	owner.get_node("AnimationPlayer").play("damage1")


func _on_animation_finished(_anim_name):
#	assert(anim_name == "damage1")
	emit_signal("finished", "idle")
