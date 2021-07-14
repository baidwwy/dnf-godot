extends StaticBody2D

onready var pic:Sprite = $pic;

func _ready():
	$Area2D.connect("body_entered",self,"_on_Area2D_body_entered");
	$Area2D.connect("body_exited",self,"_on_Area2D_body_exited");


func _on_Area2D_body_entered(body):
	if body.name == "Character":
		pic.modulate.a = 0.4;


func _on_Area2D_body_exited(body):
	pic.modulate.a = 1;
