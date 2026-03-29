extends Control

var scroll_speed = GlobalStatics.scroll_speed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("game over")
	


func _on_quit_pressed() -> void:
	print("quit game")
	get_tree().quit()


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	GlobalStatics.scroll_speed = scroll_speed
	
