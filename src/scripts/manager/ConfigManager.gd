extends Node

#经验配置
var exptableConfig:ExptableConfig;
#职业基础数据
var jobBaseConfig:JobBaseConfig;
#职业升级加成数据
var jobUpConfig:JobUpConfig;
#技能配置
var skillConfigProxy:SkillConfigProxy;
#装备配置
var equipConfigProxy:EquipConfigProxy;
#怪物配置
var monsterConfig:MonsterConfig;

func _ready():
	exptableConfig = ExptableConfig.new();
	jobBaseConfig = JobBaseConfig.new();
	jobUpConfig = JobUpConfig.new();
	skillConfigProxy = SkillConfigProxy.new();
	equipConfigProxy = EquipConfigProxy.new();
	monsterConfig = MonsterConfig.new();
