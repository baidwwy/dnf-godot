extends Node2D

onready var effect:AnimatedSprite = $Effect;

func _ready() -> void:
	effect.play("default");


func _on_Effect_animation_finished() -> void:
	queue_free();
