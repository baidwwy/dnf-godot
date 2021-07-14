extends TextureRect
onready var icon:TextureRect = $Icon;
onready var select:TextureRect = $select;
onready var amount:Label = $amount;

func get_drag_data(_pos):
	if DataManager.storateData.data[get_index()]:
		var data = {};
		data["origin_node"] = icon;
		data["origin_panel"] = "Storate";
		var item = DataManager.storateData.data[get_index()];
		data["origin_item_id"] = item
		data["origin_equipment_slot"] = ConfigManager.equipConfigProxy.get_item_equipmentslot(item.id);
		data["origin_texture"] = icon.texture;
		
		var drag_texture = TextureRect.new()
		drag_texture.expand = true
		drag_texture.texture = icon.texture
		drag_texture.rect_size = Vector2(28,28)
		
		var control = Control.new()
		control.add_child(drag_texture)
		drag_texture.rect_position = -0.5 * drag_texture.rect_size
		set_drag_preview(control)
		
		return data
	
func can_drop_data(_pos, data):
	if data["origin_panel"] == "CharacterSheet" or data["origin_panel"] == "SkillShortcut" or data["origin_panel"] == "SkillInventory":
			return false
	
	var target_inv_index = get_index();
	if DataManager.storateData.data[target_inv_index] == null:
		data["target_item_id"] = null;
		data["target_texture"] = null;
	else:
		var item = DataManager.storateData.data[target_inv_index];
		data["target_item_id"] = item;
		data["target_texture"] = icon.texture;
	return true
	
func drop_data(_pos, data):
	#我们在此插槽中放置物品时会发生什么
#	var target_inv_slot = name;
#	var origin_slot = data["origin_node"].get_parent().name;
	var target_inv_index = get_index();
	var origin_index = data["origin_node"].get_parent().get_index();
	
	#更新原slot的数据
	if data["origin_panel"] == "Inventory":
		DataManager.invData.data[GlobalManager.main.bag.select_index][origin_index] = data["target_item_id"];
	elif data["origin_panel"] == "Storate":
		DataManager.storateData.data[origin_index] = data["target_item_id"];
	elif data["origin_panel"] == "InvShortcut":
		DataManager.invShortcutData.data[origin_index] = data["target_item_id"];
	else:
		pass
		

	#更新原slot的纹理
	if data["origin_panel"] == "CharacterSheet" and data["target_item_id"] == null:
		data["origin_node"].texture = null;
	else:
		data["origin_node"].texture = data["target_texture"];
		
	#更新目标的纹理和数据
	DataManager.storateData.data[target_inv_index] = data["origin_item_id"];
	icon.texture = data["origin_texture"];

func _on_ItemSlot_mouse_entered():
	select.visible = true;
	if DataManager.storateData.data[get_index()] != null:
		GlobalManager.main.on_show_toolTipEquip("Storate","",get_index(),get_local_mouse_position());


func _on_ItemSlot_mouse_exited():
	select.visible = false;
	GlobalManager.main.on_hide_tooltipEquip();
