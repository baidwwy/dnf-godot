extends Button

onready var clickSound:AudioStreamPlayer = $ClickSound;
onready var enteredSound := $EnteredSound;

func _ready():
	pass


func _on_Button1_pressed():
	clickSound.play();


func _on_Button1_mouse_entered():
#	enteredSound.play();
	pass
