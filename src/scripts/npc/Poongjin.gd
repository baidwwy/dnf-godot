extends "res://src/scripts/npc/NPC.gd"

onready var menu:Popup = $Menu_Type3;
onready var skillBtn:TextureButton = $Menu_Type3/MarginContainer/VBoxContainer/skillBtn;
onready var taskBtn:TextureButton = $Menu_Type3/MarginContainer/VBoxContainer/taskBtn;

func _ready():
	amb_count = 1;
	fw_count = 2;
	tk_count = 2;

#显示menu
func show_menu():
	menu.set_position(get_global_mouse_position());
	menu.popup();


func _on_talkBtn_pressed():
	pass # Replace with function body.


func _on_shopBtn_pressed():
	pass # Replace with function body.


func _on_skillBtn_pressed():
	pass # Replace with function body.


func _on_taskBtn_pressed():
	pass # Replace with function body.
