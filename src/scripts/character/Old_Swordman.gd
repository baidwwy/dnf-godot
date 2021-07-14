extends "res://src/scripts/character/Old_Character.gd"
#class_name Swordman

#var body_resource = preload("res://assets/images/character/swordman/body/sm_body0000.png");
var weapon_resource = preload("res://assets/images/character/swordman/kanata/katana0001.png");
var attack1_sound = preload("res://assets/sounds/swordman/sm_atk_01.ogg");
var attack2_sound = preload("res://assets/sounds/swordman/sm_atk_02.ogg");
var attack3_sound = preload("res://assets/sounds/swordman/sm_atk_03.ogg");

func _ready() -> void:
#	body.texture = body_resource;
#	shadow.texture = body_resource;
	weapon.texture = weapon_resource;
	mainPlayer.playback_speed = 1

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_left") and direction == DIRECTION.LEFT:
		velocity.x = direction;
		setDirection();
	elif Input.is_action_pressed("ui_right") and direction == DIRECTION.RIGHT:
		velocity.x = direction;
		setDirection();
	elif Input.is_action_pressed("ui_left"):
		direction = DIRECTION.LEFT;
		setDirection();
	elif Input.is_action_pressed("ui_right"):
		direction = DIRECTION.RIGHT;
		setDirection();
		
	if Input.is_action_pressed("ui_up"):
		velocity.y = -max_yspeed;
	elif Input.is_action_pressed("ui_down"):
		velocity.y = max_yspeed;
	
	if Input.is_action_pressed("attack") and state == STATE.IDLE and check_attack():
		combo_timer.start();
		state = STATE.ATTACK;
		velocity = Vector2.ZERO;
		attack_combo += 1;
		if attack_combo > attack_max_combo:
			attack_combo = 1;
			
	if Input.is_action_just_pressed("skill1"):
		state = STATE.SKILL1;
	
	if Input.is_action_just_pressed("shortcut1"):
		cast_skill(6);
	if Input.is_action_just_pressed("shortcut2"):
		cast_skill(7);
	
	
	change_state();
	
	match state:
		STATE.IDLE:
			idle_motion(delta);
		STATE.MOVE:
			walk_motion(delta);
		STATE.RUN:
			run_motion(delta);
		STATE.ATTACK:
			attack_motion();
		STATE.SKILL1:
			skill1_motion();
	
#站街
func idle_motion(_delta):
	mainPlayer.play("rest");
	velocity = Vector2.ZERO;
	
#走
func walk_motion(_delta:float):
	mainPlayer.play("move");
	velocity.x *= max_walkspeed;
	move();
	
#跑
func run_motion(_delta:float):
	mainPlayer.play("dash");
	velocity.x *= max_runspeed;
	move();
	
#移动
func move():
	velocity =	move_and_slide(velocity);
	velocity = Vector2.ZERO;

#普通攻击
func attack_motion():
	mainPlayer.play("attack" + str(attack_combo));
	attackCanCombo = false;
	
#普通攻击可连招
func attack_can_combo_back():
#	print("可以连招")
	attackCanCombo = true;
	
#普通攻击动画播放结束
func attack_animation_complete():
	state = STATE.IDLE;

#播放普通攻击的音效
func play_attack_sound():
	if state != STATE.ATTACK:
		return;
	
	var random:int = int(ceil(rand_range(0,3)));
	match random:
		1:
			soundPlayer.stream = attack1_sound;
		2:
			soundPlayer.stream = attack2_sound;
		3:
			soundPlayer.stream = attack3_sound;
	if soundPlayer.playing == true:
		soundPlayer.stop();
	soundPlayer.play();

#技能1
func skill1_motion():
#	mainPlayer.play("hardattack")
	mainPlayer.play("upperslash");
#	if not main_body.has_node("Upperslash_Effect"):
#		var upper = upperslash.instance();
#		main_body.add_child(upper);
#		if direction == DIRECTION.LEFT:
#			upper.get_node("Sprite").flip_h = true;

#切换状态
func change_state():
	if not state == STATE.ATTACK and not state == STATE.SKILL1 and not state == STATE.SKILL:
		if velocity != Vector2.ZERO:
			if velocity.x != 0 and input_data["left_taps"] == 2 or input_data["right_taps"] == 2:
				state = STATE.RUN;
			else:
				state = STATE.MOVE;
		else:
			state = STATE.IDLE;

#施放技能
func cast_skill(index:int):
	var skl_data = DataManager.skillShortcutData.data[index];
	if skl_data != null:
			cast_skill(skl_data.id);
			state = STATE.SKILL;
	
	match skl_data.id:
		1003:
			skill1_motion();
		1018:
			mainPlayer.play("hardattack");

#设置方向
func setDirection():
	flip_h(direction == DIRECTION.LEFT);

#连接计时器结束
func _on_Combo_Timer_timeout():
	state = STATE.IDLE;
	attack_combo = 0;
	attackCanCombo = true;
