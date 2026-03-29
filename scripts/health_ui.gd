extends Control

@onready var h_box_container: HBoxContainer = $HBoxContainer



func _init_health_ui(current_health) -> void:
	show()
	
	for health in current_health:
		print("adding HEALTH ICON!")
		var heart_icon = load("res://scenes/UI/health_icon.tscn").instantiate()
		
		h_box_container.add_child(heart_icon)


func _update_health_ui(current_health) -> void:
	
	for child in h_box_container.get_children():
		child.queue_free()
	
	for health in current_health:
		print("adding HEALTH ICON!")
		var heart_icon = load("res://scenes/UI/health_icon.tscn").instantiate()
		
		h_box_container.add_child(heart_icon)
