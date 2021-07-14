extends Node2D

export(String) var bgm:String = "";
export(String) var env:String = "";
export(String) var stageType:String = "normal";

onready var bg:ParallaxBackground = $environment/background;
onready var doors:Node2D = $doors;
onready var topLeft:Position2D = $TopLeft;
onready var bottomRight:Position2D = $BottomRight;
onready var stage:YSort = $stage;
var player:KinematicBody2D;

func _ready():
	bg.transform.origin = global_position;
	

#添加玩家
func addPlayer(p:KinematicBody2D,p_pos:Vector2,_isBorn:bool = false):
	player = p;
	if _isBorn:
		player.position = $Born.position;
	else:
		player.position = p_pos;
		
	stage.add_child(player);
	player.setCameralimit(topLeft.global_position.y,topLeft.global_position.x,
		bottomRight.global_position.y,bottomRight.global_position.x);
	
	GlobalManager.main.changeBGM(bgm);
	GlobalManager.main.changeENV(env);

#删除玩家
func removePlayer():
	if stage.get_node("Character"):
		stage.remove_child(stage.get_node("Character"));

#切换门状态
func change_door_state(value:bool):
	var doorArr = doors.get_children();
	for door in doorArr:
		if door is Area2D:
			door.setState(value);
			if not value:
				door.setConnect();
			else:
				door.setDisconnect();

#获取相对门的位置
func get_door_position() -> Vector2:
	print("正在找的门，to_" + GlobalManager.state.current)
	
	var door = doors.get_node("to_" + GlobalManager.state.current);
	var dpos = door.get_node("pos");
	return door.position + dpos.position;
