extends CharacterBody2D

var tween


func _ready() -> void:
	tween = create_tween()
	
	tween.tween_property(self, "rotation", 90, 6)

	
