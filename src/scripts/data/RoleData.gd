extends Node
class_name RoleData

#生命值变更
#signal hp_change;
#MP变更
#signal mp_change;

#职业基础名字
var job_base:String = "";
#当前职业名字
var job:String = "";
#是否觉醒
var aweek:int = 0;
#金币
var gold:int = 0;
#等级
var lv:int = 1;
#经验
var expe:int = 0;
#经验值上限
var max_expe:int = 0;
#sp点
var sp:int = 0;
#HP最大值
var max_hp:int = 0;
#
var hp:int = 0 setget set_hp;
#MP最大值
var max_mp:int = 0;
#
var mp:int = 0;
#物品負重上限(數值/1000)
var inventory_limit:int = 0;
#重量(千分之一)
var weight:int = 0;
#力量
var STR:int = 0;
#智力
var WIS:int = 0;
#体力
var VIT:int = 0;
#精神
var MND:int = 0;
#物理攻击
var physical_attack:int = 0;
#魔法攻击
var magical_attack:int = 0;
#物理防御
var physical_defense:int = 0;
#魔法防御
var magical_defense:int = 0;
#物理暴击
var physical_critical:float = 0;
#魔法暴击
var magical_critical:float = 0;
#攻击速度
var attack_speed:float = 0;
#施放速度
var cast_speed:float = 0;
#移动速度
var move_speed:float = 0;
#命中率
var stuck:float = 0;
#回避率
var stuck_resistance:float = 0;
#每分鐘恢復HP
var hp_regen_speed:int = 0;
#每分鐘恢復MP
var mp_regen_speed:int = 0;
#僵直
var immobility:int = 0;
#硬直
var hit_recovery:int = 0;
#攻击类型：普通，火属性，冰属性，光属性，暗属性
var attack_type:int = 0;
#火属性强化
var fire_attack:int = 0;
#冰属性强化
var water_attack:int = 0;
#光属性强化
var light_attack:int = 0;
#暗属性强化
var dark_attack:int = 0;
#火属性抗性
var fire_resistance:int = 0;
#水属性抗性
var water_resistance:int = 0;
#光属性抗性
var light_resistance:int = 0;
#暗属性抗性
var dark_resistance:int = 0;
#失明抗性
var blind_resistance:int = 0;
#感电/灼伤抗性
var lightning_resistance:int = 0;
#冰冻抗性
var freeze_resistance:int = 0;
#束缚抗性
var hold_resistance:int = 0;
#睡眠抗性
var sleep_resistance:int = 0;
#出血抗性
var bleeding_resistance:int = 0;
#混乱抗性
var confuse_resistance:int = 0;
#诅咒抗性
var curse_resistance:int = 0;
#石化抗性
var stone_resistance:int = 0;



func _init():
	pass

func init_data():
	lv = 10;
	sp = 100;
	max_expe = ConfigManager.exptableConfig.get_exp(lv);
	#加载基础数据
	var base:Dictionary = ConfigManager.jobBaseConfig.get_data(job_base);
	max_hp = base["HP_MAX"];
	hp = max_hp;
	max_mp = base["MP_MAX"];
	mp = max_mp;
	STR = base["physical_attack"];
	VIT = base["physical_defense"];
	WIS = base["magical_attack"];
	MND = base["magical_defense"];
	light_resistance = base["light_resistance"];
	dark_resistance = base["dark_resistance"];
	inventory_limit = base["inventory_limit"];
	mp_regen_speed = base["mp_regen_speed"];
	hit_recovery = base["hit_recovery"];
	weight = base["weight"];
	#加载职业数据
	var up:Dictionary = ConfigManager.jobUpConfig.get_job_data(job);
	max_hp += up["HP_MAX"] * lv;
	hp = max_hp;
	max_mp += up["MP_MAX"] * lv;
	mp = max_mp;
	STR += int(round(up["physical_attack"] * lv));
	VIT += int(round(up["physical_defense"] * lv));
	WIS += int(round(up["magical_attack"] * lv));
	MND += int(round(up["magical_defense"] * lv));
	inventory_limit += up["inventory_limit"] * lv;
	mp_regen_speed += up["mp_regen_speed"] * lv;
	hit_recovery += up["hit_recovery"] * lv;
	

func set_hp(value:int):
	hp = value;
