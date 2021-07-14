extends Control

onready var expBar:TextureProgress = $expBar;
onready var fatigueBar:TextureProgress = $fatigueBar;
onready var hpBar:TextureProgress = $hpBar;
onready var mpBar:TextureProgress = $mpBar;
onready var SP:Label = $SP;
onready var lv:Label = $lv;
#道具栏快捷键
onready var invShort:Control = $InvShortcut;
#技能栏快捷键
onready var skillShort:Control = $SkillShortcutGrid;

# Called when the node enters the scene tree for the first time.
func _ready():
	init_data();

#初始化
func init_data():
	lv.text = str(DataManager.roleData.lv);
	expBar.value = (DataManager.roleData.expe / DataManager.roleData.max_expe) * 100.0;
	hpBar.value = (DataManager.roleData.hp / DataManager.roleData.max_hp) * 100.0;
	mpBar.value = (DataManager.roleData.mp / DataManager.roleData.max_mp) * 100.0;
	SP.text = str(DataManager.roleData.sp);
	
	#初始化道具栏数据
	var data:Array = DataManager.invShortcutData.data;
	for i in range(0,data.size()):
		if not data[i] == null:
			var slot:TextureRect = invShort.get_child(i);
			var icon_path = GLOBALS_TYPE.ICON_PATH + ConfigManager.equipConfigProxy.get_item_icon(data[i].id);
			var icon_texture = load(icon_path);
			slot.get_node("Icon").texture = icon_texture;
	#初始化技能栏数据
	var skill_data:Array = DataManager.skillShortcutData.data;
	for i in range(0,skill_data.size()):
		if not skill_data[i] == null:
			var slot:TextureRect = skillShort.get_child(i);
			var id:int = skill_data[i]["id"];
			var icon_name:String = ConfigManager.skillConfigProxy.get_icon_by_ID(DataManager.roleData.job_base,id);
			var icon_path:String = GLOBALS_TYPE.SKILL_ICON_PATH + icon_name;
			var icon_texture = load(icon_path);
			slot.get_node("Icon").texture = icon_texture;
			slot.get_node("lv").text = str(skill_data[i]["show_lv"]);
			slot.get_node("static_lv").visible = true;
			slot.get_node("lv").visible = true;
			

#更新数据
func refresh(index:int):
	var slot:TextureRect = skillShort.get_child(index);
	var id:int = DataManager.skillShortcutData.data[index]["id"];
	var icon_name:String = ConfigManager.skillConfigProxy.get_icon_by_ID(DataManager.roleData.job_base,id);
	var icon_path:String = GLOBALS_TYPE.SKILL_ICON_PATH + icon_name;
	var icon_texture = load(icon_path);
	slot.get_node("Icon").texture = icon_texture;
	slot.get_node("lv").text = str(DataManager.skillShortcutData.data[index]["show_lv"]);
	slot.get_node("lv").visible = true;
	slot.get_node("static_lv").visible = true;
	SP.text = str(DataManager.roleData.sp);


#打开背包
func _on_bag():
	GlobalManager.main._on_open_bag();

#打开人物状态面板
func _on_state():
	GlobalManager.main._on_open_status();


func _on_fight():
	owner.infoMenu.popup();

#打开技能面板
func _on_tutBtn_pressed():
	pass # Replace with function body.
	owner._on_open_skill();

#设置
func _on_setBtn_pressed():
	owner.optionMenu.popup();
