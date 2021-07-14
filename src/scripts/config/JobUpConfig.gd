extends "res://src/scripts/config/BaseConfig.gd"
class_name JobUpConfig

func _init():
	load_json("res://assets/configs/JobUp.json");
	
func get_job_data(job:String) -> Dictionary:
	var job_data:Dictionary;
	for i in data.size():
		if data[i]["job"] == job:
			job_data = data[i];
			break; 
	
	return job_data;
	
