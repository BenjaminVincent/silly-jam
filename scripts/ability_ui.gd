extends Control

@onready var h_box_container: HBoxContainer = $HBoxContainer

var button_label = ["Q", "E"] 
var counter = 0



func update_abilities(ability_list) -> void:
	
	counter = 0
	
	for child in h_box_container.get_children():
		child.queue_free()
	
	for ability in ability_list:
		print("drawing new ability")
		var ability_button = load("res://scenes/ability_button.tscn").instantiate()
		ability_button.texture_normal = ability.icon
		
		if counter == 0:
			ability_button.get_node("Label").text = button_label[0]
		else:
			ability_button.get_node("Label").text = button_label[1]
		
		h_box_container.add_child(ability_button)
		counter += 1
		
