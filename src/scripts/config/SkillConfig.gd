class_name SkillConfig

var ID:int = 0;

var name:String = "";
#英文名字
var name2:String = "";
#描述
var explain:String = "";
#SP消耗
var purchase_cost:int = 0;
#可偷学
var steel_learning_skill:int = 0;
#学习等级
var required_level:int = 1;
#跳级需求，技能提升等级需要的人物等级
var required_level_range:int = 1;
#前置技能
var pre_required_skill:Array = [];
#技能类型    被动 主动
var type:String = "";
#技能栏位置
var skill_class:int = 0;
#等级上限
var maximum_level:int = 0;
#职业对应的等级上限
var growtype_maximum_level:Array = [];
#职业分类
var skill_fitness_growtype:int = 0;
#是否是觉醒技能
var skill_fitness_second_growtype:int = 0;
#耐久度下降率
var durability_decrease_rate:int = 0;
#武器效果类型
var weapon_effect_type:String = ""; 
#屏幕震动
var shake_screen:String = "";
#图标
var icon:String = "";
#指令
var command:String = "";
#技能指挥优势
var skill_command_advantage:Array= []
#消耗MP
var consume_MP:Array = [];
#施法时间
var casting_time:Array = [];
#冷却时间
var cool_time:Array = [];
#静态数据
var static_data:Array = [];
#等级信息
var level_info:Array = [];
#指令说明
var command_key_explain:String = "";
#技能伤害描述
var level_property:String = "";
#技能伤害描述参数
var level_property_value:Array = []; 
#消耗无色小晶块
var consume_item:int = 0;
#技能预加载图像
var skill_preloading_image:String = "";
#
var special_level_up:String = "";
#

#
