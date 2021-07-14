extends Control

onready var face:TextureRect = $face;
onready var type:TextureRect = $type;
onready var nameLabel:Label = $nameLabel;
onready var progress:ColorRect = $progress;

var status:MonsterStatus;
#一层的血量值
export(int) var singleLayerHP:int = 100;
#总血量
var totalHP:int = 700;
#当前血量
var currentHP:int = 650 setget set_currentHP,get_currentHP;

func _ready() -> void:
	pass

func init_data(st:MonsterStatus):
	status = st;
	nameLabel.text = "Lv." + str(status.lv) + " " + status.name;
	face.texture = load("res://assets/images/face/monster/" + status.face);
	if status.category == "human":
		pass
	
	totalHP = status.max_hp;
	set_currentHP(status.hp)
	
func set_currentHP(value):
	if value > 0:
		currentHP = value;
	else:
		currentHP = 0;
	progress.showHPLayer();

func get_currentHP() -> int:
	return currentHP;

