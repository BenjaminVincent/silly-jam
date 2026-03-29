extends Control
@onready var score_label: Label = $Score

var score = 0

func get_score(inventory) -> void:

	for item in inventory.values():
		score += item.quantity * item.gold
	print("total score: ", score)
	score_label.text = "Score: " + str(score)
