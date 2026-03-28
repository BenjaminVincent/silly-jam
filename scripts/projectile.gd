extends Node2D

@onready var audio_stream_player_2: AudioStreamPlayer = $AudioStreamPlayer

var velocity: Vector2



func _process(delta):
	position += velocity * delta



func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:

	if body.is_in_group("enemies"):
		if body.health >= 0 and body.can_take_damage:
			print("about to play sound")
			audio_stream_player_2.play()
			body.take_damage(1)


func _on_audio_stream_player_finished() -> void:
	queue_free()
