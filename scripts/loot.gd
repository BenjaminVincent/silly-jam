extends Node2D

var velocity: Vector2

var speed = 40

func _process(delta):
	position += Vector2(-40, 0) * delta


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()


#
#func _on_area_2d_body_entered(body: Node2D) -> void:
#
	#if body.is_in_group("enemies"):
		#if body.health >= 0:
			#body.take_damage(1)
		#queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("player collected loot!")
		queue_free()
