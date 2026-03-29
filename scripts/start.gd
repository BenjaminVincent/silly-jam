extends Control

@onready var level = preload("res://scenes/level.tscn").instantiate()
@onready var texture_rect: TextureButton = $TextureRect

var tween

func _on_texture_rect_pressed() -> void:
	get_parent().add_child(level)
	hide()


func _on_texture_rect_mouse_entered() -> void:
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	texture_rect.scale = Vector2(0.8, 0.8)
	tween.tween_property(texture_rect, "scale", Vector2(1.0, 1.0), 0.2)
