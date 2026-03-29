extends Control
@onready var score_label: Label = $Score

var score = 0

func get_score(inventory) -> void:

	for item in inventory.values():
		score += item.quantity * item.gold
	print("total score: ", score)
	score_label.text = "Score: " + str(score)


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	GlobalStatics.scroll_speed = 70
