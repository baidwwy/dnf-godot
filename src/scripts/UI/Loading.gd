extends Control

onready var aplayer:AnimationPlayer = $AnimationPlayer;

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false;

#切换城镇
func change_town():
	self.visible = true;
	var texture = load(Utils.get_town_cutscene());
	$cutscene.texture = texture;
	var tit_text = load(Utils.get_town_title());
	$title.texture = tit_text;
	$AnimationPlayer.play("town_cutscene");
	
func completeAnimation():
	self.visible = false;

#进入地下城
func enter_dungeon():
	self.visible = true;
	var texture = load(Utils.get_dungeon_cutscene());
	$cutscene.texture = texture;
	$dungeon_title.frames = load(Utils.get_dungeon_title());
	$AnimationPlayer.play("enter_dungeon");
	
	
#进入地下城的动画播放到一半的时候
func dungeon_at_mid():
	GlobalManager.main.enterDungeon2();
	

#地下城切换stage时的loading
func change_stage():
	self.visible = true;
	$AnimationPlayer.play("change_stage");
