extends Node2D


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var gold = 0

var loot_name = ""

var velocity: Vector2

var speed = 40

var tween
var tween_2
var loot_data: Item


func _ready() -> void:
	
	
	if loot_data:
		loot_name = loot_data.item_name
		sprite_2d.texture = loot_data.texture
		gold = loot_data.gold
	
	tween = create_tween()
	scale = Vector2(0.6, 0.5)
	tween.tween_property(self, "scale", Vector2(1.3, 1.4), 0.1)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)
	tween.set_trans(Tween.TRANS_SINE)

func _process(delta):
	position += Vector2(-40, 0) * delta



func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		audio_stream_player.play()
		body.add_to_inventory(loot_name, gold)
		tween_2 = create_tween()
		scale = Vector2(1.0, 1.0)
		tween_2.tween_property(self, "scale", Vector2(1.3, 1.4), 0.1)
		tween_2.tween_property(self, "scale", Vector2(0.0, 0.0), 0.1)
		tween_2.set_trans(Tween.TRANS_SINE)
		await tween.finished
		hide()


func _on_audio_stream_player_finished() -> void:
	queue_free()
