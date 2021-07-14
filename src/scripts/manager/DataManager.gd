extends Node

#人物数据
var roleData:RoleData;
#技能数据
var skillData:SkillData;
#装备数据
var equipData:EquipData;
#背包数据
var invData:InventoryData;
#仓库数据
var storateData:StorateData;
#快捷栏道具
var invShortcutData:InvShortcutData;
#快捷栏技能数据
var skillShortcutData:SkillShortcutData;

func _ready():
	roleData = RoleData.new();
	skillData = SkillData.new();
	equipData = EquipData.new();
	invData = InventoryData.new();
	storateData = StorateData.new();
	invShortcutData = InvShortcutData.new();
	skillShortcutData = SkillShortcutData.new();
	
func init_data():
	roleData.init_data();
	skillData.init_data();
	skillShortcutData.init_data();


#获取技能等级
func get_skill_lv(id:int) -> int:
	var lv:int = 0;
	var skl_lv:int = skillData.get_skill_lv(id);
	var short_lv:int = skillShortcutData.get_skill_lv(id);
	if skl_lv != 0 or short_lv != 0:
		lv = max(skl_lv,short_lv);
	
	return lv;
