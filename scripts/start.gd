extends Control


@onready var level = preload("res://scenes/level.tscn").instantiate()

func _on_texture_rect_pressed() -> void:
	#level.instantiate()
	get_parent().add_child(level)
	hide()
