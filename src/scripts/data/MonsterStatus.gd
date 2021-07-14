extends Node
class_name MonsterStatus
#配置表ID
var id:int = 1;
#头像
var face:String = "";
#名字
#var name:String = "";
#最大生命值
var max_hp = 1;
#生命值
var hp:int = 0;
#等级
var lv:int = 1;
#物理攻击
var physical_attack:int = 0;
#物理防御
var physical_defense:int = 0;
#魔法攻击
var magical_attack:int = 0;
#魔法防御
var magical_defense:int = 0;
#类别
var category:String = "";
#火炕
var fire_resistance:int = 0;
#冰抗
var water_resistance:int = 0;
#光抗
var light_resistance:int = 0;
#暗抗
var dark_resistance:int = 0;
#攻击速度
var attack_speed:int = 0;
#移动速度
var move_speed:int = 0;
#施法速度
var cast_speed:int = 0;
#硬直
var hit_recovery:int = 0;
#重量
var weight:int = 0;
#视野范围
var sight:int = 0;
#好战度
var warlike:int = 0;
#攻击延迟
var attack_delay:int = 0;
#掉落
var items:Dictionary;

func _ready():
	hp = max_hp;

func init_data():
	var config:Dictionary = ConfigManager.monsterConfig.get_config(id);
	name = config.name;
	face = config.face;
	lv = config.lv_min;
	max_hp = config.hp_max;
	hp = max_hp;
	physical_attack = config.physical_attack;
	physical_defense = config.physical_defense;
	magical_attack = config.magical_attack;
	magical_defense = config.magical_defense;
	category = config.category;
	fire_resistance = config.fire_resistance;
	water_resistance = config.water_resistance;
	light_resistance = config.light_resistance;
	dark_resistance = config.dark_resistance;
	attack_speed = config.attack_speed;
	move_speed = config.move_speed;
	cast_speed = config.cast_speed;
	hit_recovery = config.hit_recovery;
	weight = config.weight;
	sight = config.sight;
	warlike = config.warlike;
	attack_delay = config.attack_delay;
	items = {};
	var temp1:Array = config.item.split("#");
	for t in temp1:
		var temp2:Array = t.split(":");
		items[temp2[0]] = temp2[1];
	
