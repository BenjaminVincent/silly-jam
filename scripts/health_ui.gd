extends Control

@onready var h_box_container: HBoxContainer = $HBoxContainer


func _ready() -> void:
	var player = get_tree().get_first_node_in_group("player")
	print("player: ", player)


func _init_health_ui(current_health) -> void:
	show()
	
	for health in current_health:
		var heart_icon = load("res://scenes/UI/health_icon.tscn").instantiate()
		h_box_container.add_child(heart_icon)


func _update_health_ui(current_health) -> void:
	pass
