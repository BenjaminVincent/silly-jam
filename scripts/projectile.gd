extends Node2D


var velocity: Vector2



func _process(delta):
	position += velocity * delta


#func _physics_process(delta):
	#move_and_collide(self.velocity * delta)

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()


#func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	#pass # Replace with function body.





#func _on_area_2d_area_entered(area: Area2D) -> void:
	#
		#if area.is_in_group("enemies"):
			##body.take_damage(10)
			#print("collided with enemy")
			#queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:

	if body.is_in_group("enemies"):
		body.take_damage(1)
		print("collided with enemy")
		queue_free()
