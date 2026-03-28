extends Node2D


var velocity: Vector2

func _process(delta):
	position += velocity * delta


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
