extends Control

const min_hard:int = 0;
const max_hard:int = 3;

export(PackedScene) var dungeon:Resource;

onready var normalbg = $normalbg;
onready var normalbtn = $normalBtn;
onready var selectbg = $selectbg;
onready var selectBtn = $selectBtn;
onready var maoxian = $maoxian;
onready var yongshi = $yongshi;
onready var king = $king;
onready var leftbtn = $leftBtn;
onready var rightbtn = $rightBtn;
var index:int = 0;

func _ready():
	reset2normal();

#聚焦当前按钮
func _on_normalBtn_pressed():
	normalbg.visible = false;
	normalbtn.visible = false;
	selectBtn.visible = true;
	selectbg.visible = true;
	rightbtn.visible = true;
	index = 0;
	GlobalManager.select_dungeon = name;
	GlobalManager.select_dungeon_scene = dungeon;
	GlobalManager.change_dungeon();

#鼠标移入
func _on_normalBtn_mouse_entered():
	normalbg.visible = true;

#鼠标移出
func _on_normalBtn_mouse_exited():
	normalbg.visible = false;

#难度选择按钮左
func _on_leftBtn_pressed():
	index -= 1;
	if index <= min_hard:
		leftbtn.visible = false;
	if index != max_hard:
		rightbtn.visible = true;
	change_hard();

#难度选择按钮右
func _on_rightBtn_pressed():
	index += 1;
	if index >= max_hard:
		rightbtn.visible = false;
	if index != min_hard:
		leftbtn.visible = true;
	change_hard();

#进入副本
func _on_enter_map():
	pass # Replace with function body.

func change_hard():
	match index:
		0:
			set_hard_image(false,false,false);
		1:
			set_hard_image(true,false,false);
		2:
			set_hard_image(false,true,false);
		3:
			set_hard_image(false,false,true);
			
func set_hard_image(value1:bool,value2:bool,value3:bool):
	maoxian.visible = value1;
	yongshi.visible = value2;
	king.visible = value3;

#重置默认状态
func reset2normal():
	normalbg.visible = false;
	normalbtn.visible = true;
	selectbg.visible = false;
	selectBtn.visible = false;
	maoxian.visible = false;
	yongshi.visible = false;
	king.visible = false;
	leftbtn.visible = false;
	rightbtn.visible = false;
