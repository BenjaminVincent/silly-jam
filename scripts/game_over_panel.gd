extends Control

var scroll_speed = GlobalStatics.scroll_speed



func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	GlobalStatics.scroll_speed = scroll_speed
	
