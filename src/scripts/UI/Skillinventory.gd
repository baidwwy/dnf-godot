extends Control

onready var tab1:Button = $Tab_Button1;
onready var tab2:Button = $Tab_Button2;
onready var tab3:Button = $Tab_Button3;
onready var tab4:Button = $Tab_Button4;
onready var tab5:Button = $Tab_Button5;
onready var grid1:GridContainer = $grid1;
onready var grid2:GridContainer = $grid2;
onready var grid3:GridContainer = $grid3;
onready var grid4:GridContainer = $grid4;
onready var grid5:GridContainer = $grid5;
#sp
onready var sp:Label = $SP;


var select_index:int = 0;

func _ready() -> void:
	tab1.pressed = true;
	init_data();

#初始化数据
func init_data():
	for index in range(0,5):
		var list:Array = DataManager.skillData.data[index];
		var grid:GridContainer = get_node("grid" + str(index + 1));
		for i in range(0,list.size()):
			if list[i] != null:
				var node:TextureRect = grid.get_child(i);
				var icon_path:String = GLOBALS_TYPE.SKILL_ICON_PATH + ConfigManager.skillConfigProxy.get_icon_by_ID(DataManager.roleData.job,list[i]["id"]);
				var icon_tetxture = load(icon_path);
				node.get_node("Icon").texture = icon_tetxture;
	sp.text = str(DataManager.roleData.sp);

#刷新数据
func refresh(class_index:int,slot_int:int):
	var list:Array = DataManager.skillData.data[class_index];
	var grid:GridContainer = get_node("grid" + str(class_index + 1));
	var node:TextureRect = grid.get_child(slot_int);
	var icon_path:String = GLOBALS_TYPE.SKILL_ICON_PATH + ConfigManager.skillConfigProxy.get_icon_by_ID(DataManager.roleData.job,list[slot_int]["id"]);
	var icon_tetxture = load(icon_path);
	node.get_node("Icon").texture = icon_tetxture;
	node.get_node("lv").text = str(list[slot_int]["show_lv"]);
	node.get_node("lv").visible = true;
	node.get_node("static_lv").visible = true;
	sp.text = str(DataManager.roleData.sp);
	

#锁定按钮
func _on_lockBtn_pressed():
	pass # Replace with function body.

#解锁按钮
func _on_unclockBtn_pressed():
	pass # Replace with function body.

func can_drop_data(_position, data):
	if data["origin_panel"] == "SkillShortcut":
		var skill_class:int = ConfigManager.skillConfigProxy.get_class_by_ID(DataManager.roleData.job_base,data["origin_item_id"]["id"]);
		if select_index != skill_class:
			match skill_class:
				0:
					tab1.pressed = true;
				1:
					tab2.pressed = true;
				2:
					tab3.pressed = true;
				3:
					tab4.pressed = true;
				4:
					tab5.pressed = true;
	else:
		return false;

#控制grid的显示
func show_grid(v1:bool,v2:bool,v3:bool,v4:bool,v5:bool):
	grid1.visible = v1;
	grid2.visible = v2;
	grid3.visible = v3;
	grid4.visible = v4;
	grid5.visible = v5;
	

func _on_Tab_Button1_toggled(button_pressed):
	if button_pressed == true:
		show_grid(true,false,false,false,false);
		select_index = 0;


func _on_Tab_Button2_toggled(button_pressed):
	if button_pressed == true:
		show_grid(false,true,false,false,false);
		select_index = 1;


func _on_Tab_Button3_toggled(button_pressed):
	if button_pressed == true:
		show_grid(false,false,true,false,false);
		select_index = 2;


func _on_Tab_Button4_toggled(button_pressed):
	if button_pressed == true:
		show_grid(false,false,false,true,false);
		select_index = 3;


func _on_Tab_Button5_toggled(button_pressed):
	if button_pressed == true:
		show_grid(false,false,false,false,true);
		select_index = 4;

#关闭
func _on_closeBtn_pressed():
	GlobalManager.main._on_open_skill();

func _on_Skillinventory_visibility_changed():
	$windowSound.play();
