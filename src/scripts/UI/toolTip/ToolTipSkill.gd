extends Control

onready var nameLabel:Label = $bg/MarginContainer/VBoxContainer/NameLabel;
onready var name2Label:Label = $bg/MarginContainer/VBoxContainer/Name2Label;
onready var mpLabel:Label = $bg/MarginContainer/VBoxContainer/MPLabel;
#施法时间
onready var castTime:Label = $bg/MarginContainer/VBoxContainer/HBoxContainer/CastTime;
#冷却时间
onready var coolTime:Label = $bg/MarginContainer/VBoxContainer/HBoxContainer/CoolTime;
#消耗无色小晶块
onready var consume:Label = $bg/MarginContainer/VBoxContainer/Consume;
#操作指令
onready var operate:Label = $bg/MarginContainer/VBoxContainer/Operate;
#技能伤害属性
onready var levelProperty:Label = $bg/MarginContainer/VBoxContainer/LevelProperty;
#技能描述
onready var explain:Label = $bg/MarginContainer/VBoxContainer/Explain;
#锁定提示
onready var lockTip:Label = $bg/MarginContainer/VBoxContainer/LockTip;

#var origin = "";
#var slot_index:int = 0;
var offset_pos:Vector2 = Vector2.ZERO;
var id:int;
var lv:int;

func _ready():
	pass
	

func init_data():
	
	
	var skl:SkillConfig = ConfigManager.skillConfigProxy.get_skl_by_ID(DataManager.roleData.job_base,id);
	nameLabel.text = skl.name + " Lv " + str(lv);
	name2Label.text = skl.name2;
	if not skl.consume_MP.empty():
		var mp:int = int(cal_diff(skl.consume_MP,skl.maximum_level));
		mpLabel.text = "MP %d" % [mp];
	else:
		mpLabel.text = "";
	
	if skl.type == "passive":#被动技能
		castTime.text = "施放方式：被动";
		coolTime.text = "";
	else:
		if not skl.casting_time.empty():
			var cast:float = cal_diff(skl.casting_time,skl.maximum_level) / 1000;
			castTime.text = "施放时间：%.1f秒" % [cast];
		else:
			castTime.text = "瞬发";
		
		if not skl.cool_time.empty():
			var cool:float = cal_diff(skl.cool_time,skl.maximum_level) / 1000;
			coolTime.text = "冷却时间:%.1f秒" % [cool];
		else:
			coolTime.text = "";
	#消耗无色
	if skl.consume_item < 0:
		consume.text = "[无色小晶块]%d个" % skl.consume_item;
		consume.visible = true;
	else:
		consume.visible = false;
	#操作指令
	if skl.command_key_explain.length() > 0:
		operate.text = skl.command_key_explain;
		operate.visible = true;
	else:
		operate.visible = false;
	#技能伤害属性
	if skl.level_property.length() > 0:
		var values:Array = [];
		for arr in skl.level_property_value:
			if arr[0] < 0:
				pass
				var info = skl.level_info[lv - 1];
				values.append(info[arr[1]] * arr[2]);
			else:
				if skl.ID == 1001: #裂波斩
					values.append(skl.static_data[1].to_int());
		levelProperty.text = skl.level_property % values;
		levelProperty.visible = true;
		$bg/MarginContainer/VBoxContainer/HSeparator2.visible = true;
	else:
		levelProperty.visible = false;
		$bg/MarginContainer/VBoxContainer/HSeparator2.visible = false;
	#技能描述
	explain.text = skl.explain;
	
#	rect_size.y = lockTip.rect_position.y + lockTip.rect_size.y + 12;
	
#计算差值
#@data 	需要计算的属性
#@lv	技能当前等级
#@max_lv	技能等级上限
func cal_diff(data:Array,max_lv:int) -> float:
	var base:int = data[0].to_int();
	var lv_use:float = 0;
	if data[0].to_int() != data[1].to_int():
		var diff:int = data[1].to_int() - data[0].to_int();
		#升级提升的MP消耗量
		lv_use = round((diff / max_lv) * lv);
	var result:float = base + lv_use;
	
	return result;

func _on_LockTip_draw():
	pass # Replace with function body.
	rect_size.y = lockTip.rect_position.y + lockTip.rect_size.y + 12;
	
	var mouse_pos:Vector2 = get_global_mouse_position();
	var pos:Vector2 = Vector2(Utils.less_check(mouse_pos.x - rect_size.x - offset_pos.x,0),Utils.less_check(mouse_pos.y - rect_size.y - offset_pos.y,0));
	rect_position = pos;
