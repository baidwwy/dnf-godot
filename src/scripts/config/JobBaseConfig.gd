extends "res://src/scripts/config/BaseConfig.gd"
class_name JobBaseConfig

#鬼剑士基础属性
func _init():
	load_json("res://assets/configs/JobBase.json");
	
func get_data(job:String) -> Dictionary:
	var job_data:Dictionary;
	for i in data.size():
		if data[i]["job"] == job:
			job_data = data[i];
			break; 
	
	return job_data;
