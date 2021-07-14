extends TextureButton

#名字
onready var nameLabel:Label = $nameLabel;
#图标
onready var icon:TextureRect = $icon;
#前置技能
onready var notip:TextureRect = $notip;
#人物等级需求
onready var lvtip:TextureRect = $Lvtip;
#等级需求文本
onready var lv_tip:Label = $lv_tip;
#SP需求
onready var spLabel:Label = $spLabel;
onready var select:NinePatchRect = $select;
#技能不能学的时候显示红色图片
onready var red_color:ColorRect = $red_color;
#技能配置表
var skl:SkillConfig;
#技能当前要学习的等级
var lv:int;
#可以学习
var can_learn:bool = true;


func _ready():
	select.visible = false;
	init_data();

func init_data():
	nameLabel.text = skl.name;
	var icon_texture = load(GLOBALS_TYPE.SKILL_ICON_PATH + skl.icon);
	icon.texture = icon_texture;
	spLabel.text = str(skl.purchase_cost);
	
	notip.visible = false;
	#学习1级技能的等级需求
	var c_lv:int = skl.required_level;
	#学习当前等级的需求
	var n_lv:int = c_lv + (lv - 1) * skl.required_level_range;
	
	#检查SP
	if skl.purchase_cost > DataManager.roleData.sp:
		spLabel.set("custom_colors/font_color","ff3232");
		can_learn = false;
	else:
		spLabel.set("custom_colors/font_color","ffffff");
	
	#人物等级
	var role_lv:int = DataManager.roleData.lv;
	if n_lv > role_lv:
		can_learn = false;
		lv_tip.text = str(n_lv);
		lvtip.visible = true;
		lv_tip.visible = true;
	else:
		lvtip.visible = false;
		lv_tip.visible = false;
		
	#检查前置技能
	var pre_check:bool = true;
	var pre_skill_arr:Array = skl.pre_required_skill;
	var length:int = pre_skill_arr.size() / 2;
	for i in range(0,length):
		var pre_skl_lv:int = DataManager.get_skill_lv(pre_skill_arr[i * 2].to_int());
		if pre_skl_lv < pre_skill_arr[i * 2 + 1].to_int():
			pre_check = false;
			break;
	if pre_check == true:
		notip.visible = false;
	else:
		notip.visible = true;
		can_learn = false;
	
	
	if can_learn == false:
		nameLabel.set("custom_colors/font_color","ff3232");
		red_color.visible = true;
	else:
		nameLabel.set("custom_colors/font_color","ffffff");
		red_color.visible = false;
	
	


func _on_icon_mouse_entered():
	GlobalManager.main.on_show_toolTipSkill(skl.ID,lv,get_local_mouse_position());


func _on_icon_mouse_exited():
	GlobalManager.main.on_hide_toolTipSkill();
