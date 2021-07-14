extends "res://src/scripts/npc/NPC.gd"


func _ready():
	pass

#点击
func _on_mouse_check_pressed():
	GlobalManager.main._on_open_storate();
