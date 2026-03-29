extends Panel

var tween
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var texture_button: TextureButton = $TextureButton

func _ready() -> void:
	print("IS READY!!!!!!!!!!")

#
#func _on_mouse_entered() -> void:
	#print("mouse over")
	#tween = create_tween()
	#tween.set_ease(Tween.EASE_OUT)
	##tween.set_trans(Tween.TRANS_QUAD)
	##tween.tween_property(icon, "scale", Vector2(1, 1), 0.33)
	#sprite_2d.scale = Vector2(0.8, 0.8)
	#tween.tween_property(sprite_2d, "scale", Vector2(1.0, 1.0), 0.2)


func _on_texture_button_mouse_entered() -> void:
	print("OVER!")
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	#tween.set_trans(Tween.TRANS_QUAD)
	#tween.tween_property(icon, "scale", Vector2(1, 1), 0.33)
	texture_button.scale = Vector2(0.8, 0.8)
	tween.tween_property(texture_button, "scale", Vector2(1.0, 1.0), 0.2)
