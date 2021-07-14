extends Control

var origin = "";
var slot = "";
var slot_index:int = 0;
var offset_pos:Vector2 = Vector2.ZERO;

func init_data():
	var mouse_pos:Vector2 = get_global_mouse_position();
	var pos:Vector2 = Vector2(Utils.less_check(mouse_pos.x - rect_size.x - offset_pos.x,0),Utils.less_check(mouse_pos.y - rect_size.y - offset_pos.y,0));
	rect_position = pos;
	
#	var item_id:int;
#	if origin == "Inventory":
#		if DataManager.invData.data[GlobalManager.main.bag.select_index][slot_index] != null:
#			item_id = DataManager.invData.data[GlobalManager.main.bag.select_index][slot_index]["id"];
#	elif origin == "CharacterSheet":
#		if DataManager.equipData.equipment_data[slot] != null:
#			item_id = DataManager.equipData.equipment_data[slot]["id"];
#	elif origin == "Storate":
#		if DataManager.storateData.data[slot_index] != null:
#			item_id = DataManager.storateData.data[slot_index]["id"];
#	elif origin == "InvShortcut":
#		if DataManager.invShortcutData.data[slot_index] != null:
#			item_id = DataManager.invShortcutData.data[slot_index]["id"];
