extends KinematicBody2D

export(String) var type:String = "normal";

onready var body:Sprite = $BodyPivot/Offset/Body;
onready var shadow:Sprite = $Shadow;
var knockback = Vector2.ZERO;
#属性
var status:MonsterStatus;

func _ready():
	pass

func _physics_process(_delta):
	var direction:bool = get_direction();
	flip_h(direction);
	
	knockback = knockback.move_toward(Vector2.ZERO,_delta * 200);
	knockback = move_and_slide(knockback);
	
func flip_h(value:bool):
	body.flip_h = value;
	shadow.flip_h = value;

#受到伤害
func _on_HurtBox_area_entered(area):
	var direction:bool = get_direction();
	var dir:int = 1 if direction == true else -1;
	knockback = Vector2.RIGHT * 50 * dir;
	print("受到伤害")

#判断方向
func get_direction() -> bool:
	var value:bool = false;
#	owner.get_node("Character").global_position;
	var player_position:Vector2 = GlobalManager.main.player.global_position;
	if player_position.x < global_position.x:
		value = true;
	else:
		value = false;
	return value;
