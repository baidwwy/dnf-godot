extends "res://src/scripts/config/BaseConfig.gd"
class_name SkillConfigProxy

#鬼剑士技能
var sm_skl:Array = [];

func _init():
	load_json("res://assets/configs/SwordmanSkill.json");
	_init_skl(GLOBALS_TYPE.SWORDMAN);

#初始化技能
func _init_skl(job:String):
	var arr:Array = [];
	
	for i in range(0,data.size()):
		var dic:Dictionary = data[i];
		var skl:SkillConfig = SkillConfig.new();
		skl.ID = dic["ID"];
		skl.name = dic["name"];
		skl.name2 = dic["name2"];
		skl.explain = dic["explain"];
		skl.purchase_cost = dic["purchase_cost"];
		skl.steel_learning_skill = dic["steel_learning_skill"];
		skl.required_level = dic["required_level"];
		skl.required_level_range = dic["required_level_range"];
		if typeof(dic["pre_required_skill"]) == TYPE_STRING:
			skl.pre_required_skill = dic["pre_required_skill"].split("<A>");
		skl.type = dic["type"];
		skl.skill_class = dic["skill_class"];
		skl.maximum_level = dic["maximum_level"];
		skl.growtype_maximum_level = dic["growtype_maximum_level"].split("<A>");
		skl.skill_fitness_growtype = dic["skill_fitness_growtype"];
		skl.skill_fitness_second_growtype = dic["skill_fitness_second_growtype"];
		skl.durability_decrease_rate = dic["durability_decrease_rate"];
		if typeof(dic["weapon_effect_type"]) == TYPE_STRING:
			skl.weapon_effect_type = dic["weapon_effect_type"];
		if typeof(dic["shake_screen"])  == TYPE_STRING:
			skl.shake_screen = dic["shake_screen"];
		skl.icon = dic["icon"];
		skl.command = dic["command"];
		if typeof(dic["skill_command_advantage"]) == TYPE_STRING:
			skl.skill_command_advantage = dic["skill_command_advantage"].split("<A>");
		if typeof(dic["consume_MP"]) == TYPE_STRING:
			skl.consume_MP = dic["consume_MP"].split("<A>");
		if typeof(dic["casting_time"])  == TYPE_STRING:
			skl.casting_time = dic["casting_time"].split("<A>");
		if typeof(dic["cool_time"])  == TYPE_STRING:
			skl.cool_time = dic["cool_time"].split("<A>");
		if typeof(dic["static_data"])  == TYPE_STRING:
			skl.static_data = dic["static_data"].split("<A>");
		if typeof(dic["level_info"])  == TYPE_STRING:
			var templist:Array = dic["level_info"].split("<A>");
			var length:int = templist.pop_front().to_int();
			var list:Array = [];
#			list.resize(templist.size() / length);
			for j in range(0,templist.size(),length):
				var item:Array = [];
				var count:int = length;
				var index:int = j;
				while(count > 0):
					item.append(templist[index].to_int());
					index += 1;
					count -= 1;
				list.append(item);
			skl.level_info = list;
		if typeof(dic["command_key_explain"])  == TYPE_STRING:
			skl.command_key_explain = dic["command_key_explain"];
		if typeof(dic["level_property"])  == TYPE_STRING:
			var p_temp:Array = dic["level_property"].split("<A>");
			skl.level_property = p_temp.pop_front().replace("<N>","\n");
			var list:Array = [];
			for j in range(0,p_temp.size(),3):
				var item:Array = [];
				var count:int = 3;
				var index:int = j;
				while(count > 0):
					item.append(p_temp[index].to_float());
					index += 1;
					count -= 1;
				list.append(item);
			skl.level_property_value = list;
		skl.consume_item = dic["consume_item"];
		if typeof(dic["skill_preloading_image"])  == TYPE_STRING:
			skl.skill_preloading_image = dic["skill_preloading_image"];
		arr.append(skl);
		
	match job:
		GLOBALS_TYPE.SWORDMAN:
			sm_skl = arr;
		GLOBALS_TYPE.FIGHTER:
			pass
		GLOBALS_TYPE.GUNNER:
			pass
		GLOBALS_TYPE.MAGE:
			pass
		GLOBALS_TYPE.PRIEST:
			pass


#获取技能列表
func get_slk_list(job_base:String,job:String) -> Array:
	var list:Array = get_list_by_job(job_base);
	var arr:Array = [];
	for skl in list:
		if skl.skill_fitness_growtype == 1234:
			arr.append(skl);
	
	var job_index:int = get_job_index(job);
	#如果是-1表示还没转职
	if job_index > -1:
		for skl in list:
			if skl.skill_fitness_growtype == job_index:
				arr.append(skl);
	
	
	return arr;



#根据类型获取技能列表
func get_skl_by_type():
	pass

#根据ID获取技能数据
func get_skl_by_ID(job:String,id:int) -> SkillConfig:
	var skl:SkillConfig;
	var arr:Array = get_list_by_job(job);
	for sk in arr:
		if sk.ID == id:
			skl = sk;
			break;
	return skl;

#技能的class分类
func get_class_by_ID(job:String,id:int) -> int:
	var c:int = 0;
	var arr:Array = get_list_by_job(job);
	for sk in arr:
		if sk.ID == id:
			c = sk.skill_class;
			break;
	return c;

#技能的图标资源
func get_icon_by_ID(job:String,id:int) -> String:
	var icon:String = ""
	var arr:Array = get_list_by_job(job);
	for sk in arr:
		if sk.ID == id:
			icon = sk.icon;
			break;
	return icon;

#根据职业
func get_list_by_job(job:String) -> Array:
	var arr:Array;
	match job:
		GLOBALS_TYPE.SWORDMAN:
			arr = sm_skl;
		GLOBALS_TYPE.FIGHTER:
			pass
		GLOBALS_TYPE.GUNNER:
			pass
		GLOBALS_TYPE.MAGE:
			pass
		GLOBALS_TYPE.PRIEST:
			pass
	return arr;


#返回职业index
func get_job_index(job:String) -> int:
	var index:int = -1;
	match job:
		GLOBALS_TYPE.BLADEMASTER:
			index = 1;
		GLOBALS_TYPE.SOULBENDER:
			index = 2;
		GLOBALS_TYPE.BERSERKER:
			index = 3;
		GLOBALS_TYPE.ASURA:
			index = 4;
			
	return index;
		
		
