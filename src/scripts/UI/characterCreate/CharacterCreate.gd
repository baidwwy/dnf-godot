extends Control

onready var cut_swordman:Sprite = $cutscene_swordman;
onready var cut_fighter:Sprite = $cutscene_fighter;
onready var cut_gunner:Sprite = $cutscene_gunner;
onready var cut_mage:Sprite = $cutscene_mage;
onready var cut_priest:Sprite = $cutscene_priest;

onready var swordmanBtn:TextureButton = $swordmanBtn;
onready var fighterBtn:TextureButton = $fighterBtn;
onready var gunnerBtn:TextureButton = $gunnerBtn;
onready var mageBtn:TextureButton = $mageBtn;
onready var priestBtn:TextureButton = $priestBtn;

onready var job_title:Sprite = $job_title;
onready var job_hard:Sprite = $job_hard;
onready var job_des:Sprite = $job_des;

onready var tween:Tween = $Tween;
onready var clickSound:AudioStreamPlayer = $clickSound;

onready var createWindow:Panel = $createWindow;
onready var nameText:TextEdit = $createWindow/nameText;
onready var tipLabel:Label = $createWindow/tipLabel;

var is_int:bool = true;
var select_job:String = "";

func _ready():
	swordmanBtn.pressed = true;
	createWindow.visible = false;
# warning-ignore:return_value_discarded
	ArchiveManager.connect("role_create_ok",self,"_on_role_create_ok");


#创建角色
func _on_createBtn_pressed():
	createWindow.visible = true;

#返回
func _on_backBtn_pressed():
	visible = false;


func _on_swordmanBtn_toggled(button_pressed):
	swordmanBtn.disabled = button_pressed;
	change_cutscene(true,false,false,false,false);
	job_title.texture = load("res://assets/images/charactercreate/46.png");
	job_hard.texture = load("res://assets/images/charactercreate/52.png");
	job_des.texture = load("res://assets/images/charactercreate/60.png");
	if not is_int == true:
		playBtnSound(button_pressed);
	else:
		is_int = false;
	select_job = GLOBALS_TYPE.SWORDMAN;

func _on_fighterBtn_toggled(button_pressed):
	fighterBtn.disabled = button_pressed;
	change_cutscene(false,true,false,false,false);
	job_title.texture = load("res://assets/images/charactercreate/47.png");
	job_hard.texture = load("res://assets/images/charactercreate/53.png");
	job_des.texture = load("res://assets/images/charactercreate/61.png");
	playBtnSound(button_pressed);
	select_job = GLOBALS_TYPE.FIGHTER;

func _on_gunnerBtn_toggled(button_pressed):
	gunnerBtn.disabled = button_pressed;
	change_cutscene(false,false,true,false,false);
	job_title.texture = load("res://assets/images/charactercreate/48.png");
	job_hard.texture = load("res://assets/images/charactercreate/55.png");
	job_des.texture = load("res://assets/images/charactercreate/62.png");
	playBtnSound(button_pressed);
	select_job = GLOBALS_TYPE.GUNNER;

func _on_mageBtn_toggled(button_pressed):
	mageBtn.disabled = button_pressed;
	change_cutscene(false,false,false,true,false);
	job_title.texture = load("res://assets/images/charactercreate/49.png");
	job_hard.texture = load("res://assets/images/charactercreate/56.png");
	job_des.texture = load("res://assets/images/charactercreate/63.png");
	playBtnSound(button_pressed);
	select_job = GLOBALS_TYPE.MAGE;

func _on_priestBtn_toggled(button_pressed):
	priestBtn.disabled = button_pressed;
	change_cutscene(false,false,false,false,true);
	job_title.texture = load("res://assets/images/charactercreate/50.png");
	job_hard.texture = load("res://assets/images/charactercreate/57.png");
	job_des.texture = load("res://assets/images/charactercreate/64.png");
	playBtnSound(button_pressed);
	select_job = GLOBALS_TYPE.PRIEST;

func change_cutscene(value1:bool,value2:bool,value3:bool,value4:bool,value5:bool):
	cut_swordman.visible = value1;
	cut_fighter.visible = value2;
	cut_gunner.visible = value3;
	cut_mage.visible = value4;
	cut_priest.visible = value5;
	
	if value1 == true:
# warning-ignore:return_value_discarded
		tween.interpolate_property(cut_swordman, "position",
		Vector2(-100, 241), Vector2(257, 241), 0.4,
		Tween.TRANS_QUART, Tween.EASE_OUT);
	elif value2 == true:
# warning-ignore:return_value_discarded
		tween.interpolate_property(cut_fighter, "position",
		Vector2(-200, 299), Vector2(132, 299), 0.4,
		Tween.TRANS_QUART, Tween.EASE_OUT);
	elif value3 == true:
# warning-ignore:return_value_discarded
		tween.interpolate_property(cut_gunner, "position",
		Vector2(-100, 300), Vector2(210, 300), 0.4,
		Tween.TRANS_QUART, Tween.EASE_OUT);
	elif value4 == true:
# warning-ignore:return_value_discarded
		tween.interpolate_property(cut_mage, "position",
		Vector2(-200, 215), Vector2(130, 215), 0.4,
		Tween.TRANS_QUART, Tween.EASE_OUT);
	elif value5 == true:
# warning-ignore:return_value_discarded
		tween.interpolate_property(cut_priest, "position",
		Vector2(-200, 313), Vector2(162, 313), 0.4,
		Tween.TRANS_QUART, Tween.EASE_OUT);
		
# warning-ignore:return_value_discarded
	tween.start()
	
func playBtnSound(value:bool):
	if value == true:
		clickSound.play()

#确认创建角色
func _on_okBtn_pressed():
	var length:int = Utils.get_string_length(nameText.text);
	
	if length > 13:
		tipLabel.text = "超过角色名最大长度";
		tipLabel.visible = true;
		return;
	
	
	if ArchiveManager.check_name(nameText.text):
		ArchiveManager.createRole(nameText.text,select_job);
	else:
		tipLabel.visible = true;
		tipLabel.text = "角色名重复";

#取消创建角色
func _on_cancelBtn_pressed():
	createWindow.visible = false;

func _on_role_create_ok():
	print("角色创建成功")
	nameText.text = "";
	tipLabel.text = "";
	createWindow.visible = false;
	self.visible = false;
	get_parent().get_role_list();
