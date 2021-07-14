extends Node

signal change_dungeon;

var state := {}
#拿到主关卡的引用
# warning-ignore:unused_class_variable
var main:Main = null;
#当前背景音乐名字
var current_bgm_name:String = "";
#当前环境音效名字
var current_env_name:String = "";

#当前选择的地下城的名字
var select_dungeon:String = "";
#当前选择的地下城的场景
var select_dungeon_scene:PackedScene = null;
#当前在城镇还是地下城   town dungeon 
var map_type:String = "";

#门的类型
enum TYPE{
	TOMAP,
	TOLEVEL,
	TOENTRANCE
}

#装备插槽类型
enum SLOTTYPE{
	Shoulder = 0,
	JACKET,
	PANTS,
	SHOES,
	BELT,
	WRIST,
	AMULET,
	RING,
	WEAPON,
	TITLE
}

func _ready() -> void:
	pass

#切换地图
func change_level():
	main.change_level();
	
#切换关卡
func change_stage():
	main.current_level.change_stage();
	
func open_worldmap():
	main.openWorldmap();

#使关卡的门可用
func set_door_to_use():
	emit_signal("setDoorToUse",true);
#切换副本
func change_dungeon():
	emit_signal("change_dungeon");
