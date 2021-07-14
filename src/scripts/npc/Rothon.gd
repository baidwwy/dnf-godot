extends "res://src/scripts/npc/NPC.gd"

onready var menu:Popup = $Menu_Rothon;
onready var taskBtn:TextureButton = $Menu_Rothon/MarginContainer/VBoxContainer/talkBtn;

func _ready():
	fw_count = 3;
	tk_count = 3;

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


func _on_decBtn_pressed():
	pass # Replace with function body.
