extends TextureRect

onready var icon:TextureRect = $Icon;
onready var select:TextureRect = $select;
onready var lv:Label = $lv;
onready var static_lv:TextureRect = $static_lv;

func get_drag_data(_pos):
	if DataManager.skillShortcutData.data[get_index()]:
		var data = {};
		data["origin_node"] = icon;
		data["origin_panel"] = "SkillShortcut";
		var skl:Dictionary = DataManager.skillShortcutData.data[get_index()];
		data["origin_item_id"] = skl;
		data["origin_skill_class"] = ConfigManager.skillConfigProxy.get_class_by_ID(DataManager.roleData.job,skl["id"]);
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
	if not data["origin_panel"] == "SkillInventory" and not data["origin_panel"] == "SkillShortcut":
		return false;
	
	var target_inv_index = get_index();
	if DataManager.skillShortcutData.data[target_inv_index] == null:
		data["target_item_id"] = null;
		data["target_texture"] = null;
		return true
	else:
		var skl = DataManager.skillShortcutData.data[target_inv_index];
		data["target_item_id"] = skl;
		data["target_texture"] = icon.texture;
		if data["origin_panel"] == "SkillInventory":
			var target_skill_class = ConfigManager.skillConfigProxy.get_class_by_ID(DataManager.roleData.job,skl["id"]);
			if target_skill_class == data["origin_skill_class"]:
				return true
			else:
				return false
		else:
			return true
	
func drop_data(_pos, data):
	#我们在此插槽中放置物品时会发生什么
#	var target_inv_slot = name;
#	var origin_slot = data["origin_node"].get_parent().name;
	var target_inv_index = get_index();
	var origin_index = data["origin_node"].get_parent().get_index();
	
	#更新原slot的数据
	if data["origin_panel"] == "SkillInventory":
		DataManager.skillData.data[GlobalManager.main.skill.select_index][origin_index] = data["target_item_id"];
	else:
		pass
		DataManager.skillShortcutData.data[origin_index] = data["target_item_id"];
		

	#更新原slot的纹理
	if data["target_item_id"] == null:
		data["origin_node"].texture = null;
	else:
		data["origin_node"].texture = data["target_texture"];
		
	#更新目标的纹理和数据
	if DataManager.skillShortcutData.data[target_inv_index] == null:
		DataManager.skillShortcutData.data[target_inv_index] = {};
	DataManager.skillShortcutData.data[target_inv_index] = data["origin_item_id"];
	icon.texture = data["origin_texture"];
	if data["origin_texture"] != null:
		lv.text = str(data["origin_item_id"]["show_lv"]);
		lv.visible = true;
		static_lv.visible = true;
	
	var origin_visible:bool = false;
	if data["target_item_id"]:
		origin_visible = true;
	#更新原slot的显示
	var slot = data["origin_node"].get_parent().get_parent().get_child(origin_index);
	if origin_visible == true:
		slot.lv.text = str(data["target_item_id"]["show_lv"]);
	slot.lv.visible = origin_visible;
	slot.static_lv.visible = origin_visible;

func _on_SkillShortcutSlot_mouse_entered():
	select.visible = true;
	var skl = DataManager.skillShortcutData.data[get_index()];
	if not skl == null:
		GlobalManager.main.on_show_toolTipSkill(skl.id,skl.show_lv,get_local_mouse_position());


func _on_SkillShortcutSlot_mouse_exited():
	select.visible = false;
	GlobalManager.main.on_hide_toolTipSkill()
