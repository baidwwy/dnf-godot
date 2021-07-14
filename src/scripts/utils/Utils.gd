class_name Utils

func _ready() -> void:
	pass

#双击判断
static func doubleClick(_event:InputEvent,_delta:float) -> bool:
	var value:bool = false;
	return value;

#获取城镇的cutscene
static func get_town_cutscene() -> String:
	var cut:String = "";
	cut = "res://assets/images/map/cutscene/" + GlobalManager.state.target + ".png";
	return cut;

#获取地下城的cutscene
static func get_dungeon_cutscene() -> String:
	var cut:String = "";
	match GlobalManager.select_dungeon:
		"Lorien":
			cut = "res://assets/images/map/cutscene/lorien.png";
		"LorienInside":
			cut = "res://assets/images/map/cutscene/lorien.png";
	return cut;

#获取城镇的title
static func get_town_title() -> String:
	var title:String = "";
	title = "res://assets/images/map/title/" + GlobalManager.state.target + ".png";
	return title;

#获取地下城标题资源
static func get_dungeon_title() -> String:
	var sname:String = ";"
	match GlobalManager.select_dungeon:
		"Lorien":
			sname = "res://assets/tres/dungeon_title/lorien.tres";
		"LorienInside":
			sname = "res://assets/tres/dungeon_title/lorieninside.tres";
	return sname;

#获取字符串的字符长度
static func get_string_length(name_str:String) -> int:
	var length:int = 0;
	for i in range(0,name_str.length()):
		var char_len:int = ord(name_str[i]);
		if char_len > 127:
			length += 2;
		else:
			length += 1;
	
	return length;

#根据职业获取职业中文名
static func get_ex_by_job(job:String) -> String:
	var job_zh:String;
	match job:
		GLOBALS_TYPE.SWORDMAN:
			job_zh = "鬼剑士";
		GLOBALS_TYPE.FIGHTER:
			job_zh = "格斗家";
		GLOBALS_TYPE.GUNNER:
			job_zh = "神枪手";
		GLOBALS_TYPE.MAGE:
			job_zh = "魔法师";
		GLOBALS_TYPE.PRIEST:
			job_zh = "圣职者";
		GLOBALS_TYPE.BLADEMASTER:
			job_zh = "剑魂";
		GLOBALS_TYPE.SOULBENDER:
			job_zh = "鬼泣";
		GLOBALS_TYPE.BERSERKER:
			job_zh = "狂战士";
		GLOBALS_TYPE.ASURA:
			job_zh = "阿修罗";
	return job_zh;

#返回职业类型 int
static func get_index_by_job(job:String) -> int:
	var index:int = 0;
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
	
#如果小于标准则返回标准
static func less_check(value:float,standard:float) -> float:
	var back:float;
	if value < standard:
		back = standard;
	else:
		back = value;
	return back;

#返回这个技能该职业的等级学习上限
static func get_skill_maxlv(gml:Array) -> int:
	var job_index:int = get_index_by_job(DataManager.roleData.job);
	return gml[job_index].to_int();
