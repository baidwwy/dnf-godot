extends Control

onready var equipBtn:Button = $equipBtn;
onready var stackableBtn:Button = $stackableBtn;
onready var materialBtn:Button = $materialBtn;
onready var exBtn:Button = $exBtn;
onready var questBtn:Button = $questBtn;
onready var equip_grid:GridContainer = $EquipGrid;
onready var stackable_grid:GridContainer = $Stackable;
onready var materials_grid:GridContainer = $Materials;
onready var experjob_grid:GridContainer = $Experjob;
onready var quest_grid:GridContainer = $Quest;
##槽位-肩膀
#onready var shoulder:TextureRect = $leftEquip/Shoulder;
##槽位-上衣
#onready var Jacket:TextureRect = $leftEquip/Jacket;
##槽位-裤子
#onready var Pants:TextureRect = $leftEquip/Pants;
##槽位-鞋
#onready var Shoes:TextureRect = $leftEquip/Shoes;
##槽位-腰带
#onready var Belt:TextureRect = $leftEquip/Belt;
##槽位-手镯
#onready var Wrist:TextureRect = $rightEquip/Wrist;
##槽位-项链
#onready var Amulet:TextureRect = $rightEquip/Amulet;
##槽位-戒指
#onready var Ring:TextureRect = $rightEquip/Ring;
##槽位-武器
#onready var Weapon:TextureRect = $rightEquip/Weapon;
##槽位-称号
#onready var Title:TextureRect = $rightEquip/Title;

onready var leftEquip:Control = $leftEquip;
onready var rightEquip:Control = $rightEquip;


var select_index:int = 0;

func _ready():
	equipBtn.pressed = true;
	init_inv_data();
	init_equip_data();
	

#初始化背包数据
func init_inv_data():
	for j in range(0,5):
		var data:Array = DataManager.invData.data[j];
		var grid:GridContainer;
		match j:
			0:
				grid = equip_grid;
			1:
				grid = stackable_grid;
			2:
				grid = materials_grid;
			3:
				grid = experjob_grid;
			4:
				grid = quest_grid;
		
		for i in range(0,data.size()):
			if not data[i] == null:
				var slot:TextureRect = grid.get_child(i);
				var icon_path = GLOBALS_TYPE.ICON_PATH + ConfigManager.equipConfigProxy.get_item_icon(data[i].id);
				var icon_texture = load(icon_path);
				slot.get_node("Icon").texture = icon_texture;
		
#初始化装备数据
func init_equip_data():
		
	var keys:Array = DataManager.equipData.equipment_data.keys();
	for key in keys:
		var slot:TextureRect;
		if leftEquip.has_node(key):
			slot = leftEquip.get_node(key);
		else:
			slot = rightEquip.get_node(key);
		
		if DataManager.equipData.equipment_data[key] != null:
			var icon_path = GLOBALS_TYPE.ICON_PATH + ConfigManager.equipConfigProxy.get_item_icon(DataManager.equipData.equipment_data[key]["id"]);
			var icon_texture = load(icon_path);
			slot.get_node("Icon").texture = icon_texture;
		else:
			slot.get_node("Icon").texture = null;
	

func can_drop_data(_pos, data):
	if data["origin_panel"] != "SkillShortcut" or data["origin_panel"] != "SkillInventory":
		var id:int = data["origin_item_id"]["id"];
		var item_type:int = ConfigManager.equipConfigProxy.get_item_type(id); 
		if select_index != item_type:
			match item_type:
				0:
					equipBtn.pressed = true;
				1:
					stackableBtn.pressed = true;
				2:
					material.pressed = true;
				3:
					exBtn.pressed = true;
				4:
					questBtn.pressed = true;
	else:
		return false;

func _on_closeBtn_pressed():
	GlobalManager.main._on_open_bag();


func _on_equipBtn_toggled(button_pressed):
	if button_pressed == true:
		show_grid(true,false,false,false,false);
		select_index = 0;


func _on_stackableBtn_toggled(button_pressed):
	if button_pressed == true:
		show_grid(false,true,false,false,false);
		select_index = 1;


func _on_materialBtn_toggled(button_pressed):
	if button_pressed == true:
		show_grid(false,false,true,false,false);
		select_index = 2;


func _on_exBtn_toggled(button_pressed):
	if button_pressed == true:
		show_grid(false,false,false,true,false);
		select_index = 3;


func _on_questBtn_toggled(button_pressed):
	if button_pressed == true:
		show_grid(false,false,false,false,true);
		select_index = 4;

#控制grid的显示
func show_grid(v1:bool,v2:bool,v3:bool,v4:bool,v5:bool):
	equip_grid.visible = v1;
	stackable_grid.visible = v2;
	materials_grid.visible = v3;
	experjob_grid.visible = v4;
	quest_grid.visible = v5;

#change_type
func change_type(item_type:int):
	match item_type:
		0:
			equipBtn.pressed = true;
		1:
			stackableBtn.pressed = true;
		2:
			material.pressed = true;
		3:
			exBtn.pressed = true;
		4:
			questBtn.pressed = true;


func _on_Bag_visibility_changed():
	$windowSound.play();
