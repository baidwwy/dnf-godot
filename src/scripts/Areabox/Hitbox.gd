extends Area2D
#var knockback_vector = Vector2.ZERO;
#伤害信息
var attackData:AttackData;

func _ready():
	attackData = AttackData.new();
	attackData.damage = 20;
	attackData.x_offset = 50;

func init_data():
	pass
