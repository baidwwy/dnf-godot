extends "res://src/scripts/state_machine/state.gd"
var attack1_sound = preload("res://assets/sounds/swordman/sm_atk_01.ogg");
var attack2_sound = preload("res://assets/sounds/swordman/sm_atk_02.ogg");
var attack3_sound = preload("res://assets/sounds/swordman/sm_atk_03.ogg");

#普攻最大连击数
export(int) var MAX_COMBO_COUNT = 3
#当前连击数
var combo_count = 0;
var combo:Array = ["attack1","attack2","attack3"];
#是否继续攻击
var is_combo:bool = false;
#是否可以combo
var can_combo:bool = false;

func enter():
	combo_count = 0;
	owner.get_node("AnimationPlayer").play("attack1")
	combo_count = 1;
#	owner.hitbox.knockback_vector

func handle_input(event):
	if event.is_action_pressed("attack"):
		is_combo = true;
	elif event.is_action_released("attack"):
		is_combo = false;
	if can_combo == true and is_combo == true:
		play_combo();
		can_combo = false;
func _on_animation_finished(_anim_name):
#	assert(anim_name == "damage1")
	if is_combo == true:
		play_combo();
	else:
		emit_signal("finished", "idle")
		

func play_combo():
	owner.get_node("AnimationPlayer").play(combo[combo_count]);
	combo_count += 1;
	if combo_count > MAX_COMBO_COUNT - 1:
		combo_count = 0;

func attack_sound():
	var soundPlayer = owner.get_node("AudioStreamPlayer");
	if soundPlayer.playing == true:
		soundPlayer.stop();
	var random:int = int(ceil(rand_range(0,3)));
	match random:
		1:
			soundPlayer.stream = attack1_sound;
		2:
			soundPlayer.stream = attack2_sound;
		3:
			soundPlayer.stream = attack3_sound;
			
	soundPlayer.play();
