extends "res://src/scripts/town/LevelBase.gd"

onready var gate = get_node("Gate");

func _ready():
	pass

#设置玩家
func setPlayer(_p,isinit:bool=true):
	player = _p;
	var current;
	if isinit:
		gate.addPlayer(player,Vector2.ZERO,isinit);
		gate.change_door_state(false);
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
	
	var tar = get_node(GlobalManager.state.target);
	var p_pos:Vector2 = tar.get_door_position();
	tar.addPlayer(player,p_pos);
	tar.change_door_state(false);
	
func getStage() -> Node:
	return get_node(GlobalManager.state.stage);
