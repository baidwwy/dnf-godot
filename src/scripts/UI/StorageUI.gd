extends Control

var slot_resource = preload("res://src/scenes/UI/slot/StorateSlot.tscn")

onready var gridcontainer = $GridContainer;

func _ready():
	var data:Array = DataManager.storateData.data;
	for item in data:
		var slot = slot_resource.instance();
		if not item == null:
			var icon_path = GLOBALS_TYPE.ICON_PATH + ConfigManager.equipConfigProxy.get_item_icon(item.id);
			var icon_texture = load(icon_path);
			slot.get_node("Icon").texture = icon_texture;
		gridcontainer.add_child(slot,true);


func _on_closeBtn_pressed():
	GlobalManager.main._on_open_storate();
