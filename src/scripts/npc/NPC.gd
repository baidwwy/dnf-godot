extends Control

#是否播放菜单音效
export(bool) var play_menu_sound:bool = true;

onready var body:AnimatedSprite = $body;
onready var talkPlayer:AnimationPlayer = $talkPlayer;
onready var range_check:Area2D = $range_check;
onready var range_timer:Timer = $range_timer;
onready var clickSound:AudioStreamPlayer = $clickSound;

#环境声音的数量
var amb_count:int = 1;
#关闭窗口的声音数量
var fw_count:int = 1;
#talk的声音数量
var tk_count:int = 1;
#范围语音是否可播放
var range_play:bool = true;

func _ready():
	var _err := range_check.connect("body_entered", self, "_on_Area2D_body_entered", [], CONNECT_DEFERRED | CONNECT_ONESHOT)

#鼠标移入
func _on_mouse_check_mouse_entered():
	body.material.set_shader_param("show_outline",true);

#鼠标移出
func _on_mouse_check_mouse_exited():
	body.material.set_shader_param("show_outline",false);


func _on_Area2D_body_entered(coll_body):
	var _err := range_check.connect("body_entered", self, "_on_Area2D_body_entered", [], CONNECT_DEFERRED | CONNECT_ONESHOT)
	if coll_body.name == "Character" and range_play == true:
		if amb_count == 1:
			talkPlayer.play("amb_01");
		else:
			var random = ceil(rand_range(0,amb_count));
			talkPlayer.play("amb_0%d" % random);
			
		range_play = false;
		range_timer.start();
		

##点击
#func _on_mouse_check_pressed():
#	pass # Replace with function body.

#点击
func _on_mouse_check_pressed():
	click_npc_tk();
	show_menu();


func _on_range_timer_timeout():
	range_play = true;

#点击NPC的语音
func click_npc_tk():
	if play_menu_sound == true:
		var random = ceil(rand_range(0,tk_count));
		talkPlayer.play("tk_0%d" % [random]);
		clickSound.play();
	
#显示menu
func show_menu():
	pass
	
