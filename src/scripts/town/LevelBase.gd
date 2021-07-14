extends Node2D

#dungeon
export(String) var type = "town";

var load_state:int = 0;
var player:KinematicBody2D;

func _ready() -> void:
	pass

#设置玩家
#func setPlayer(_p):
#	pass
