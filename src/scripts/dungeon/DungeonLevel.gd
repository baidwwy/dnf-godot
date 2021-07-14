extends Node2D

#dungeon
export(String) var type = "dungeon";

var load_state:int = 0;
var player:KinematicBody2D;
var bornStage:String = "";

func _ready() -> void:
	pass

##设置玩家
func setPlayer(_p,isinit:bool=true):
	player = _p;
	var current;
	if isinit:
		current = get_node(bornStage);
		current.addPlayer(player,Vector2.ZERO,true);
		current.change_door_state(false);
	else:
		current = getStage();
		var p_pos:Vector2 = current.get_door_position();
		current.addPlayer(player,p_pos);
		current.change_door_state(false);

#切换stage
func change_stage():
	var curr = get_node(GlobalManager.state.current);
	curr.removePlayer();
	curr.change_door_state(true);

	GlobalManager.main.loading.change_stage();
	var tar = get_node(GlobalManager.state.target);
	var p_pos:Vector2 = tar.get_door_position();
	tar.addPlayer(player,p_pos);
	tar.change_door_state(false);

func getStage() -> Node:
	return get_node(GlobalManager.state.stage);
