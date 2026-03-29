extends Control

var score = 0

func get_score(inventory) -> void:

	for item in inventory.values():
		score += item.quantity * item.gold
	print("total score: ", score)
