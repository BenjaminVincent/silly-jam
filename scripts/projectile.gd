extends Node2D


var velocity: Vector2



func _process(delta):
	position += velocity * delta



func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:

	if body.is_in_group("enemies"):
		if body.health >= 0:
			body.take_damage(1)
		queue_free()
