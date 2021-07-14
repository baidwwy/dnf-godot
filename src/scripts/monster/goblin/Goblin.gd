extends "res://src/scripts/monster/Monster.gd"


func _ready():
	status = MonsterStatus.new();
	status.id = 1;
	status.init_data();

#受到伤害
func _on_HurtBox_area_entered(area):
	var attackData:AttackData = area.attackData;
	var direction:bool = get_direction();
	var dir:int = 1 if direction == true else -1;
	knockback = Vector2.RIGHT * attackData.x_offset * dir;
	status.hp -= attackData.damage;
	if status.hp < 0:
		status.hp == 0;
	GlobalManager.main.monsterHP.show_hp(type,status);
