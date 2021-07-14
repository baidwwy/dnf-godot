extends Control

onready var buttons:Control = $buttons;
onready var openhell:TextureButton = $openHellBtn;
onready var closehell:TextureButton = $closeHellBtn;

func _ready():
	GlobalManager.connect("change_dungeon",self,"change_dungeon");
	initselect();
	closehell.visible = false;

#进入地下城
func _on_enterBtn_pressed():
	GlobalManager.main.enterDungeon1();
	queue_free();

#返回城镇
func _on_backBtn_pressed():
	queue_free();

#开启深渊模式
func _on_openHellBtn_pressed():
	openhell.visible = false;
	closehell.visible = true;

#关闭深渊模式
func _on_closeHellBtn_pressed():
	openhell.visible = true;
	closehell.visible = false;

#打开界面的时候默认选择第一项
func initselect():
	var children = buttons.get_children();
	var lens = buttons.get_child_count();
	for i in range(0,lens):
		if i == 0:
			children[i]._on_normalBtn_pressed();

func change_dungeon():
	var children = buttons.get_children();
	for btn in children:
		if not btn.name == GlobalManager.select_dungeon:
			btn.reset2normal();
