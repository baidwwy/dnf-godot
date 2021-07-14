extends TextureButton

const swordman_position:Vector2 = Vector2(52,96);
const fighter_position:Vector2 = Vector2(62,153);


onready var focus:TextureRect = $focus;
onready var select:TextureRect  = $select;
onready var nameLabel:Label = $nameLabel;
onready var jobLabel:Label = $jobLabel;
onready var bottom:AnimatedSprite = $bottom;

var data = null;
var character:Sprite;

func _ready():
	focus.visible = false;
	select.visible = false;
	if data == null:
		nameLabel.visible = false;
		jobLabel.visible = false;


func _on_acter_mouse_entered():
	if data == null:
		return;
	focus.visible = true;


func _on_acter_mouse_exited():
	focus.visible = false;

func create_role():
	match data["role"]["job"]:
		GLOBALS_TYPE.SWORDMAN:
			character = load("res://src/scenes/character/Swordman_show.tscn").instance();
			character.position = swordman_position;
		GLOBALS_TYPE.FIGHTER:
			character = load("res://src/scenes/character/Fighter_show.tscn").instance();
			character.position = fighter_position;
	add_child(character);
	
	nameLabel.text = "Lv." + str(data["role"]["lv"]) + " " + data["role"]["name"];
	nameLabel.visible = true;
	jobLabel.text = Utils.get_ex_by_job(data["role"]["job"]);
	jobLabel.visible = true;
