extends CanvasLayer

onready var normalHp:Control = $Monster_HP_Normal;
onready var eliteHP:Control = $Monster_HP_Elite;
onready var bossHp:Control = $Monster_HP_BOSS;


func _ready() -> void:
	pass


func show_hp(type:String,status:MonsterStatus):
	if type == "normal":
		_change_hp(true,false,false);
		normalHp.init_data(status);
	elif type == "elite":
		_change_hp(false,true,false);
	elif type == "boss":
		_change_hp(false,false,true);


func _change_hp(value1:bool,value2:bool,value3:bool):
	if normalHp.visible != value1:
		normalHp.visible = value1;
	if eliteHP.visible != value2:
		eliteHP.visible = value2;
	if bossHp.visible != value3:
		bossHp.visible = value3;
