extends TextureRect

onready var icon:TextureRect = $Icon;
onready var select:TextureRect = $select;

func get_drag_data(_pos):
	var equipment_slot:String = name;
	if DataManager.equipData.equipment_data[equipment_slot] != null:
		var data = {};
		data["origin_node"] = icon
		data["origin_panel"] = "CharacterSheet"
		data["origin_item_id"] = DataManager.equipData.equipment_data[equipment_slot];
		data["origin_equipment_slot"] = equipment_slot
		data["origin_texture"] = icon.texture
		
		var drag_texture = TextureRect.new()
		drag_texture.expand = true
		drag_texture.texture = icon.texture
		drag_texture.rect_size = Vector2(28,28)
		
		var control = Control.new()
		control.add_child(drag_texture)
		drag_texture.rect_position = -0.5 * drag_texture.rect_size
		set_drag_preview(control)
		
		#切换背包的类别
		var item_type:int = ConfigManager.equipConfigProxy.get_item_type(DataManager.equipData.equipment_data[equipment_slot]["id"]); 
		get_parent().get_parent().change_type(item_type);
		return data
	
func can_drop_data(_pos, data):
	if data["origin_panel"] == "SkillShortcut" or data["origin_panel"] == "SkillInventory":
			return false
	
	var target_equipment_slot = name;
	if target_equipment_slot == data["origin_equipment_slot"]:
		if DataManager.equipData.equipment_data[target_equipment_slot] == null:
			data["target_item_id"] = null
			data["target_texture"] = null
		else:
			data["target_item_id"] = DataManager.equipData.equipment_data[target_equipment_slot]
			data["target_texture"] = icon.texture
		return true
	else:
		return false
	
func drop_data(_pos, data):
	#我们在此插槽中放置物品时会发生什么
	var target_equipment_slot = name
	var origin_slot = data["origin_node"].get_parent().name
#	var target_equipment_index = get_index()
	var origin_index = data["origin_node"].get_parent().get_index()
	
	#更新原slot的数据
	if data["origin_panel"] == "Inventory":
		DataManager.invData.data[get_parent().get_parent().select_index][origin_index] = data["target_item_id"]
	else:	#CharacterSheet
		DataManager.equipData.equipment_data[origin_slot] = data["target_item_id"]
		
	#更新原slot的纹理
	if data["origin_panel"] == "CharacterSheet" and data["target_item_id"] == null:
		data["origin_node"].texture = null
	else:
		data["origin_node"].texture = data["target_texture"]
		
	#更新目标的纹理和数据
	DataManager.equipData.equipment_data[target_equipment_slot] = data["origin_item_id"]
	icon.texture = data["origin_texture"]


func _on_EquipSlot_mouse_entered():
	select.visible = true;
	if DataManager.equipData.equipment_data[name] != null:
		GlobalManager.main.on_show_toolTipEquip("InvShortcut",name,0,get_local_mouse_position());


func _on_EquipSlot_mouse_exited():
	select.visible = false;
	GlobalManager.main.on_hide_tooltipEquip();
