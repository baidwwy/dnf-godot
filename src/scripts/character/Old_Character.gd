extends KinematicBody2D
#class_name Character

enum DIRECTION{
	LEFT = -1,
	RIGHT = 1
}

enum STATE{
	IDLE,
	MOVE,
	RUN,
	ATTACK,
	JUMP,
	SKILL1,
	SKILL
}

onready var main_body:KinematicBody2D = $Body;
#动画播放器
onready var mainPlayer:AnimationPlayer = $MainPlayer;
#身体
onready var body:Sprite = $Body/body;
#影子
onready var shadow:Sprite = $Body/shadow;

onready var weapon:Sprite = $Body/weapon;
#特效层
onready var effect:Sprite = $Body/effect;
#摄像机
onready var camera:Camera2D = $Camera2D;
#双击跑计时器
onready var dcTimer:Timer = $Double_Click_Timer;
#普通攻击连接计时器
onready var combo_timer = $Combo_Timer;
#名字
onready var nameLabel:Label =$Body/nameLabel;
#等级
onready var lvLabel:Label = $Body/lvLabel;
#音频播放器
onready var soundPlayer:AudioStreamPlayer = $soundPlayer;

#按钮双击判定
var input_data:Dictionary = {
	"left_taps":0,
	"right_taps":0,
	"timer":0,
	"reset_time":1
}

#状态机
var state = STATE.IDLE;
#方向
var direction = DIRECTION.RIGHT;
#移动方向
var velocity:Vector2 = Vector2.ZERO;
#重力
var gravity:int = 35;
#Y方向移动速度
var max_yspeed:int = 180;
#走步速度
var max_walkspeed:int = 150;
#跑步速度
var max_runspeed:int = 300;
#跳跃力
var jumpforce:int = -1100;
var ACCELERATION = 500;
var FRICTION = 0;
#普通攻击连招数上限
var attack_max_combo:int = 3;
#普通攻击连招数
var attack_combo:int = 0;
var attackCanCombo:bool = true;

#是否正在跳跃
var is_jumping:bool = false;

func _ready():
	nameLabel.text = DataManager.roleData.name;
	lvLabel.text = "Lv." + str(DataManager.roleData.lv);

func _process(_delta: float) -> void:
	doubleclick();

#设置摄像机边界
func setCameralimit(top:float,left:float,bottom:float,right:float):
	# warning-ignore:narrowing_conversion
		camera.limit_top = round(top);
	# warning-ignore:narrowing_conversion
		camera.limit_left = round(left);
	# warning-ignore:narrowing_conversion
		camera.limit_bottom = round(bottom);
	# warning-ignore:narrowing_conversion
		camera.limit_right = round(right);
	
func setDisabled(value:bool) -> void:
	print("设置玩家的碰撞")
	$CollisionShape2D.set_deferred("disabled",value)
	
#翻转贴图
func flip_h(value:bool):
	body.flip_h = value;
	shadow.flip_h = value;
	weapon.flip_h = value;
	effect.flip_h = value;


func _on_Double_Click_Timer_timeout():
	if input_data["timer"] > 0:
		input_data["timer"] -= 0.1;
		if input_data["timer"] <= 0:
			dcTimer.stop();
			if input_data["left_taps"] != 2:
				input_data["left_taps"] = 0;
			if input_data["right_taps"] != 2:
				input_data["right_taps"] = 0;

func doubleclick():
	if Input.is_action_just_pressed("ui_left"):
		input_data["timer"] = input_data["reset_time"];
		dcTimer.start();
		direction = DIRECTION.LEFT;
		input_data["left_taps"] += 1;
		input_data["right_taps"] = 0;
	if Input.is_action_just_pressed("ui_right"):
		input_data["timer"] = input_data["reset_time"];
		dcTimer.start();
		direction = DIRECTION.RIGHT;
		input_data["right_taps"] += 1;
		input_data["left_taps"] = 0;
	
	if Input.is_action_just_released("ui_left") and input_data["timer"] <= 0:
		input_data["left_taps"] = 0;
		dcTimer.stop();
		
	if Input.is_action_just_released("ui_right")  and input_data["timer"] <= 0:
		input_data["right_taps"] = 0;
		dcTimer.stop();

#连接计时器结束
func _on_Combo_Timer_timeout():
	pass # Replace with function body.

#判断普通攻击是否可以生效
func check_attack() -> bool:
	var value:bool = false;
	if state == STATE.ATTACK:
		if attackCanCombo == true:
			value = true;
	else:
		value = true;
	return value;
