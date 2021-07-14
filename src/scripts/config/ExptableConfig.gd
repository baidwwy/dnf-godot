extends "res://src/scripts/config/BaseConfig.gd"
class_name ExptableConfig



func _init():
	load_json("res://assets/configs/Exptable.json");

#根据等级获取经验值
func get_exp(lv:int) -> int:
	var expe:int = 0;

	for i in data.size():
		var temp = data[i];
		if temp["lv"] == lv:
			expe = temp["expe"];
			break;
	return expe;

