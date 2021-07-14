extends Area2D

const HitEffect = preload("res://src/scenes/Areabox/HitEffect.tscn");

func _ready() -> void:
	pass


func _on_HurtBox_area_entered(area: Area2D) -> void:
	var effect = HitEffect.instance();
	var p = get_parent();
	effect.position = Vector2(26,0);
	p.add_child(effect);
