extends "res://src/scripts/npc/NPC.gd"

onready var menu:Popup = $Menu_Type2;

func _ready():
	amb_count = 4;
	fw_count = 6;
	tk_count = 6;

#显示menu
func show_menu():
	menu.set_position(get_global_mouse_position());
	menu.popup();

func _on_talkBtn_pressed():
	pass # Replace with function body.


func _on_shopBtn_pressed():
	pass # Replace with function body.


func _on_taskBtn_pressed():
	pass # Replace with function body.
