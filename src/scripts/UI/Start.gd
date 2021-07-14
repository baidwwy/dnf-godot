extends Control

onready var loading:TextureRect = $Loading;
onready var scrollContainer:ScrollContainer = $SelectCharacter/ScrollContainer;
onready var acterList:GridContainer = $SelectCharacter/ScrollContainer/GridContainer;
onready var create:Panel = $CharacterCreate;
onready var clickSound:AudioStreamPlayer = $clickSound;
onready var selectSound:AudioStreamPlayer = $selectSound;

var select_data:Dictionary = {};

func _ready() -> void:
	loading.visible = true;
	create.visible = false;
#	scrollContainer.get_v_scrollbar().step = scrollContainer.rect_size.y / 2;
	get_role_list();
	

#开始游戏
func _on_StartBtn_pressed() -> void:
	clickSound.play()
	if select_data.empty():
		return;
	
	ArchiveManager.data = select_data;
	ArchiveManager.initData();
	
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Main.tscn");


func _on_closeLoading() -> void:
	loading.visible = false;

#退出游戏
func _on_quitGame() -> void:
	get_tree().quit();


#创建角色
func _on_createBtn_pressed():
	create.visible = true;


func _on_acter_toggled(button_pressed:bool, index:int):
	var btn := get_acter(index);
	select_data = {};
	if btn.data == null:
		return;
	btn.select.visible = button_pressed;
	if button_pressed == true:
		btn.bottom.frame = 1;
		selectSound.play();
		select_data = btn.data;
	else:
		btn.bottom.frame = 0;
		

func get_acter(index:int) -> TextureButton:
	pass
	var btn := acterList.get_node("acter" + str(index)) as TextureButton;
	return btn;

func get_role_list():
	var list := ArchiveManager.get_role_list();
	for i in range(0,list.size()):
		var btn := get_acter(i + 1);
		btn.data = list[i];
		btn.create_role();
	
