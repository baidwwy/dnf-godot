extends Node
#存档类,持久化数据

signal role_create_ok;

const SAVE_DIR = "user://saves/";
var save_path = SAVE_DIR + "%s.dat";

#角色数据
var roleData:Dictionary = {"name":"阿拉德","job":"swordman","lv":"12"};
#技能数据
var skill:Array = [];
#装备数据
var equipData:Dictionary = {};

var data:Dictionary = {};

func _ready():
	pass

#数据保存到本地
func save_data():
	
	var dir = Directory.new();
	if not dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR);
	
	var save_game := File.new();
	var error = save_game.open_encrypted_with_pass(save_path % [roleData["name"]],File.WRITE,"DNFyU9w18");
	if error == OK:
		save_game.store_var(data);
		save_game.close();

#从本地加载数据
func load_data():
	var path = save_path % [roleData["name"]];
	var save_game = File.new();
	if not save_game.file_exists(path):
		return;
	var error = save_game.open_encrypted_with_pass(path, File.READ,"DNFyU9w18");
	if error == OK:
		data = save_game.get_var();
	save_game.close();

func set_equipData(key:String,value):
	equipData[key] = value;


#获取全部的角色数据
func get_role_list() -> Array:
	var list:Array = [];
	
	var name_list:Array = [];
	
	var dir = Directory.new();
	if dir.open(SAVE_DIR) == OK:
		dir.list_dir_begin();
		var file_name = dir.get_next();
		while file_name != "":
			if not dir.current_is_dir():
				name_list.append(file_name);
			file_name = dir.get_next();
		dir.list_dir_end()
	
	for i in range(0,name_list.size()):
		var path = SAVE_DIR + name_list[i];
		var save_game = File.new();
		if not save_game.file_exists(path):
			continue;
		var error = save_game.open_encrypted_with_pass(path, File.READ,"DNFyU9w18");
		if error == OK:
			var file_data = save_game.get_var();
			list.append(file_data);
		save_game.close();
	
	return list;

#检查名字
func check_name(n:String) -> bool:
	var b:bool = true;
	var dir = Directory.new();
	if dir.open(SAVE_DIR) == OK:
		dir.list_dir_begin();
		var file_name = dir.get_next();
		while file_name != "":
			if not dir.current_is_dir():
				if file_name.find(n) != -1:
					b = false;
			file_name = dir.get_next();
		dir.list_dir_end()
	return b;
	
#创建角色
func createRole(n:String,job:String):
	roleData.name = n;
	roleData.job_base = job;
	roleData.job = job;
	roleData.lv = 1;
	roleData.expe = 0;
	roleData.sp = 0;
	roleData.gold = 0;
	roleData.aweek = 0;
	data.role = roleData;
	skill.clear();
	#初始化技能面板
	for _i in range(0,5):
		var temp:Array = [];
		temp.resize(42);
		skill.append(temp);
	data["skill"] = skill;
	#初始化技能快捷栏
	var sklShort:Array = [];
	sklShort.resize(12);
	match job:
		GLOBALS_TYPE.SWORDMAN:
			sklShort[6] = {"id":1003,"lv":1};
			sklShort[7] = {"id":1018,"lv":1}
		GLOBALS_TYPE.FIGHTER:
			pass
		GLOBALS_TYPE.GUNNER:
			pass
		GLOBALS_TYPE.MAGE:
			pass
		GLOBALS_TYPE.PRIEST:
			pass
	data["skillShort"] = sklShort;
	#初始化背包
	var inventory:Array = [];
	for _i in range(0,5):
		var temp:Array = [];
		temp.resize(60);
		inventory.append(temp);
	data["inventory"] = inventory;
	#初始化道具快捷栏
	var invShort:Array = [];
	invShort.resize(6);
	data["invShort"] = invShort;
	#初始化装备
	var equipment_data = {"Shoulder":null,
	"Jacket":{"id":10004},
	"Pants":{"id":10005},
	"Shoes":null,
	"Belt":null,
	"Wrist":null,
	"Amulet":null,
	"Ring":null,
	"Weapon":{"id":10001},
	"Title":null};
	data["equip"] = equipment_data;
	#初始化仓库
	var storate:Array = [];
	storate.resize(10);
	data["storate"] = storate;
	
	save_data();
	emit_signal("role_create_ok");

#进游戏时初始化数据
func initData():
	#人物数据
	DataManager.roleData.name = data["role"]["name"];
	DataManager.roleData.job_base = data["role"]["job_base"];
	DataManager.roleData.job = data["role"]["job"];
	DataManager.roleData.lv = data["role"]["lv"];
	DataManager.roleData.expe = data["role"]["expe"];
	DataManager.roleData.sp = data["role"]["sp"];
	DataManager.roleData.gold = data["role"]["gold"];
	DataManager.roleData.aweek = data["role"]["aweek"];
	#初始化技能
	DataManager.skillData.data = data["skill"];
	#初始化技能快捷栏
	DataManager.skillShortcutData.data = data["skillShort"];
	#初始化背包数据
	DataManager.invData.data = data["inventory"];
	#初始化道具快捷栏
	DataManager.invShortcutData.data = data["invShort"];
	#初始化装备
	DataManager.equipData.equipment_data = data["equip"];
	#初始化仓库
	DataManager.storateData.data = data["storate"];
	#初始化人物属性
	DataManager.init_data();
	
	
