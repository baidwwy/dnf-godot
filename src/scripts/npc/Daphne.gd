extends "res://src/scripts/npc/NPC.gd"

onready var menu:Popup = $Menu_Daphne;

func _ready():
	amb_count = 3;
	fw_count = 3;
	tk_count = 4;

#显示menu
func show_menu():
	menu.set_position(get_global_mouse_position());
	menu.popup();

func _on_talkBtn_pressed():
	pass # Replace with function body.
