extends Node
#向场景/人物发送消息
#signal key_down_scene;
#向UI发送消息
#signal key_down_ui(value);
#发送状态栏按钮消息
signal open_status;
#背包消息
signal open_bag;
#技能面板
signal open_skill;
#cancel信号
signal ui_cancel;

func _ready():
	pass

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_left"):
		pass
	if event.is_action_pressed("ui_right"):
		pass
	if event.is_action_pressed("ui_up"):
		pass
	if event.is_action_pressed("ui_down"):
		pass
	if event.is_action_pressed("status"):
		emit_signal("open_status");
	if event.is_action_pressed("bag"):
		emit_signal("open_bag");
	if event.is_action_pressed("skill"):
		emit_signal("open_skill");
	if event.is_action_pressed("ui_cancel"):
		emit_signal("ui_cancel");
	
