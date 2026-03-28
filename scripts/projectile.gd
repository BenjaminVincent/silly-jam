extends Node2D



@onready var audio_stream_player_2: AudioStreamPlayer = $AudioStreamPlayer
@onready var area_2d: Area2D = $Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D

var velocity: Vector2
var has_hit: bool = false



func _process(delta):
	position += velocity * delta



func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if has_hit: return
	
	if body.is_in_group("enemies"):
		if body.health >= 0:
			if body.can_take_damage:
				has_hit = true
				audio_stream_player_2.play()
				body.take_damage(1)
				sprite_2d.visible = false
				area_2d.set_deferred("monitoring", false)
			else:
				queue_free()



func _on_audio_stream_player_finished() -> void:
	queue_free()
