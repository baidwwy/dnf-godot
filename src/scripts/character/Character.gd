extends KinematicBody2D
# The Player is a KinematicBody2D, in other words a physics-driven object.
# It can move, collide with the world, etc...
# The player has a state machine, but the body and the state machine are separate.

#signal direction_changed(new_direction)

onready var camera:Camera2D = $Camera2D;
onready var body:Sprite = $BodyPivot/Offset/Body;
onready var shadow:Sprite = $Shadow;
onready var weapon:Sprite = $BodyPivot/Offset/Weapon;
onready var animationPlayer:AnimationPlayer = $AnimationPlayer;
#
onready var hitPivot:Position2D = $BodyPivot/Offset/hitPivot;
onready var hitbox:Area2D = $BodyPivot/Offset/hitPivot/Hitbox;

var look_direction = Vector2.RIGHT setget set_look_direction

func take_damage(attacker, amount, effect = null):
	if is_a_parent_of(attacker):
		return
	$States/Stagger.knockback_direction = (attacker.global_position - global_position).normalized()
	$Health.take_damage(amount, effect)


func set_dead(value):
	set_process_input(not value)
	set_physics_process(not value)
	$CollisionPolygon2D.disabled = value


func set_look_direction(value:Vector2):
	look_direction = value
#	emit_signal("direction_changed", value)

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
		
#翻转贴图
func flip_h(value:bool):
	body.flip_h = value;
	shadow.flip_h = value;
	weapon.flip_h = value;
	hitPivot.scale.x = -1 if value else 1;
#	effect.flip_h = value;

