class_name SkillShortcutData

var data:Array = [];

func _init():
	pass
#	data.resize(12);

#根据数据计算show_lv
func init_data():
	#根据数据计算show_lv
	for i in range(0,data.size()):
		if not data[i] == null:
			data[i]["show_lv"] = data[i]["lv"];

#获取技能已学习等级
func get_skill_lv(id:int) -> int:
	var lv:int = 0;
	for skl in data:
		if skl != null and skl.id == id:
			lv = skl["lv"];
			break;
	return lv;
