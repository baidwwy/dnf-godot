class_name SkillData

var data:Array = [];

func _init():
	pass
	
#初始化show_lv
func init_data():
	for i in range(0,5):
		var list:Array = data[i];
		for j in range(0,list.size()):
			if not list[j] == null:
				list[j]["show_lv"] = list[j]["lv"];
	
#获取技能信息
func get_skill():
	pass

#获取技能已学习等级
func get_skill_lv(id:int) -> int:
	var lv:int = 0;
	for i in range(0,5):
		var list:Array = data[i];
		for skl in list:
			if skl != null and skl.id == id:
				lv = skl["lv"];
				break;
	return lv;
