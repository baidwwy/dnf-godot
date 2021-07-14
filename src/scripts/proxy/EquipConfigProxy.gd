extends "res://src/scripts/config/BaseConfig.gd"
class_name EquipConfigProxy

#装备列表
var list:Array = [];

func _init():
	load_json("res://assets/configs/Equipment.json");
	_init_data();

func _init_data():
	for dic in data:
		var equ:EquipConfig = EquipConfig.new();
		equ.ID = dic.ID;
		equ.name = dic.name;
		equ.name2 = dic.name2;
		equ.item_type = dic.item_type;
		equ.equipment_slot = dic.equipment_slot;
		equ.equipment_physical_attack = dic.equipment_physical_attack;
		equ.equipment_magical_attack = dic.equipment_magical_attack;
		equ.equipment_physical_defense = dic.equipment_physical_defense;
		equ.equipment_magical_defense = dic.equipment_magical_defense;
		equ.sub_type = dic.sub_type;
		equ.icon = dic.icon;
		equ.move_wav = dic.move_wav;
		list.append(equ);
		

#获取装备图标
func get_item_icon(id:int) -> String:
	var icon:String = ""
	for item in list:
		if item.ID == id:
			icon = item.icon;
			break
	return icon
	
#获取装备插槽
func get_item_equipmentslot(id:int) -> String:
	var slot:String = ""
	for item in list:
		if item.ID == id:
			slot = item.equipment_slot;
			break;
	return slot
	
#获取装备栏类型
func get_item_type(id:int) -> int:
	var item_type:int = 0;
	for item in list:
		if item.ID == id:
			item_type = item.item_type;
			break;
	
	return item_type;
