extends Panel

var item_temp = preload("res://src/scenes/UI/slot/Skillbuy_Item.tscn");
var group = preload("res://src/scenes/UI/btn_group/skillbuy_buttongroup.tres");

onready var tab1:Button = $Tab_Button1;
onready var tab2:Button = $Tab_Button2;
onready var tab3:Button = $Tab_Button3;
onready var tab4:Button = $Tab_Button4;
onready var tab5:Button = $Tab_Button5;
onready var grid1:GridContainer = $skillContainer/grid1;
onready var grid2:GridContainer = $skillContainer/grid2;
onready var grid3:GridContainer = $skillContainer/grid3;
onready var grid4:GridContainer = $skillContainer/grid4;
onready var grid5:GridContainer = $skillContainer/grid5;
onready var skillContainer:ScrollContainer = $skillContainer;
#学习技能按钮
onready var learnBtn:Button = $learnBtn;
#音效播放器
onready var animation:AnimationPlayer = $AnimationPlayer;

var select_index:int = 0;
var select_item_index:int = 0;
#选择的技能ID
var select_item_id = -1;

func _ready():
	tab1.pressed = true;
	learnBtn.disabled = true;
	init_data();
	$windowSound.play();

#初始化数据
func init_data():
	var list:Array = ConfigManager.skillConfigProxy.get_slk_list(DataManager.roleData.job_base,DataManager.roleData.job);
	var grid:GridContainer;
	for skl in list:
		var skl_lv:int = DataManager.get_skill_lv(skl.ID);
		var max_lv:int = Utils.get_skill_maxlv(skl.growtype_maximum_level);
		if skl_lv < max_lv:
			var item:TextureButton = item_temp.instance();
			item.lv = skl_lv + 1;
			item.skl = skl;
			item.group = group;
			match skl.skill_class:
				0:
					grid = grid1;
				1:
					grid = grid2;
				2:
					grid = grid3;
				3:
					grid = grid4;
				4:
					grid = grid5;
			item.connect("toggled",self,"on_item_select",[grid.get_child_count(),skl.ID]);
			grid.add_child(item);
	
#选择技能
func on_item_select(pressed:bool,index:int,item_id:int):
	var grid:GridContainer = skillContainer.get_node("grid" + str(select_index + 1));
	var item = grid.get_child(index);
	if pressed == true:
		item.select.visible = true;
		select_item_index = index;
		select_item_id = item_id;
		if item.can_learn == true:
			learnBtn.disabled = false;
		else:
			learnBtn.disabled = true;
	else:
		item.select.visible = false;
	animation.play("select");


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
		
#控制grid的显示
func show_grid(v1:bool,v2:bool,v3:bool,v4:bool,v5:bool):
	grid1.visible = v1;
	grid2.visible = v2;
	grid3.visible = v3;
	grid4.visible = v4;
	grid5.visible = v5;


func _on_closeBtn_pressed():
	queue_free();
	$windowSound.play();


#学习技能
func _on_learnBtn_pressed():
	var done:bool = false;
	#获取配置表
	var sklconfig:SkillConfig = ConfigManager.skillConfigProxy.get_skl_by_ID(DataManager.roleData.job_base,select_item_id);
	var is_avtive:bool = false if sklconfig.type == "passive" else true;
	#快捷栏
	#先计算这个技能是不是已经学过了
	if is_avtive == true:
		var skill_short:Array = DataManager.skillShortcutData.data;
		for index in range(0,skill_short.size()):
			var skl_data = skill_short[index];
			if skl_data != null and skl_data["id"] == select_item_id:
				skl_data["lv"] += 1;
				skl_data["show_lv"] += 1;
				done = true;
				GlobalManager.main.hud.refresh(index);
				break;
		#如果没学过，就加新数据
		if not done:
			for i in range(0,skill_short.size()):
				if skill_short[i] == null:
					skill_short[i] = {"id":select_item_id,"lv":1,"show_lv":1};
					done = true;
					GlobalManager.main.hud.refresh(i);
					break;
	#如果快捷栏没有这个技能，并且快捷栏也没有空位
	var skill_list:Array = DataManager.skillData.data[sklconfig.skill_class];
	if not done:
		for index in range(0,skill_list.size()):
			var skl_data = skill_list[index];
			if skl_data != null and skl_data["id"] == select_item_id:
				skl_data["lv"] += 1;
				skl_data["show_lv"] += 1;
				done = true;
				GlobalManager.main.skill.refresh(sklconfig.skill_class,index);
				break;
				
	#如果没学过，就加新数据
	if not done:
		for i in range(0,skill_list.size()):
			if skill_list[i] == null:
				skill_list[i] = {"id":select_item_id,"lv":1,"show_lv":1};
				done = true;
				GlobalManager.main.skill.refresh(sklconfig.skill_class,i);
				break;
	refresh_list();
	animation.stop();
	animation.play("learn");
	
#刷新学习的技能列表，要刷整列，因为要判断是不是已经满级，满级的要从列表里剔除	
func refresh_list():
	pass
	var list:Array = ConfigManager.skillConfigProxy.get_slk_list(DataManager.roleData.job_base,DataManager.roleData.job);
	var grid:GridContainer;
	match select_index:
				0:
					grid = grid1;
				1:
					grid = grid2;
				2:
					grid = grid3;
				3:
					grid = grid4;
				4:
					grid = grid5;
	
	var count:int = grid.get_child_count();
	for i in range(0,count):
		var item:TextureButton = grid.get_child(0);
		item.disconnect("toggled",self,"on_item_select");
		grid.remove_child(item);
	
	#正在学的技能是否被清理掉了
	var is_clear:bool = true;
	#判断正在学习的时候是否已经满级被清掉，如果没有就继续，如果有，就disabled 按钮
	for skl in list:
		var skl_lv:int = DataManager.get_skill_lv(skl.ID);
		var max_lv:int = Utils.get_skill_maxlv(skl.growtype_maximum_level);
		if skl.skill_class == select_index and skl_lv < max_lv:
			var item:TextureButton = item_temp.instance();
			item.lv = skl_lv + 1;
			item.skl = skl;
			item.group = group;
			item.connect("toggled",self,"on_item_select",[grid.get_child_count(),skl.ID]);
			grid.add_child(item);
			item.select.visible = false;
			if skl.ID == select_item_id:
				item.select.visible = true;
				if item.can_learn == true:
					is_clear = false;
	learnBtn.disabled = is_clear;
