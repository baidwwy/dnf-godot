extends "res://src/scripts/config/BaseConfig.gd"
class_name MonsterConfig



func _init():
	load_json("res://assets/configs/Monster.json");

#获取配置表
func get_config(id:int) -> Dictionary:
	var config:Dictionary = {}
	for c in data:
		if c.ID == id:
			config = c;
			break;
	
	return config;
