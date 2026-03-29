extends Control

@onready var ability_panel: Panel = $AbilityPanel
@onready var ability_panel_2: Panel = $AbilityPanel2
@onready var ability_panel_3: Panel = $AbilityPanel3



var tween_1
var tween_2
var tween_3

func show_with_tween() -> void:
	modulate.a = 0.0
	show()
	
	set_panels_interactive(false)
	
	
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.3)
	
	await get_tree().create_timer(1.2).timeout
	await get_tree().process_frame
	
	ability_panel.scale = Vector2(0.0, 0.0)
	ability_panel.show()
	tween_1 = create_tween()
	tween_1.set_ease(Tween.EASE_OUT)
	ability_panel.scale = Vector2(0.8, 0.8)
	tween_1.tween_property(ability_panel, "scale", Vector2(1.0, 1.0), 0.2)


	await get_tree().create_timer(0.6).timeout
	await get_tree().process_frame
	
	ability_panel_2.scale = Vector2(0.0, 0.0)
	ability_panel_2.show()
	tween_2 = create_tween()
	tween_2.set_ease(Tween.EASE_OUT)
	ability_panel_2.scale = Vector2(0.8, 0.8)
	tween_2.tween_property(ability_panel_2, "scale", Vector2(1.0, 1.0), 0.2)
	
	await get_tree().create_timer(0.6).timeout
	await get_tree().process_frame
	
	ability_panel_3.scale = Vector2(0.0, 0.0)
	ability_panel_3.show()
	tween_3 = create_tween()
	tween_3.set_ease(Tween.EASE_OUT)
	ability_panel_3.scale = Vector2(0.8, 0.8)
	tween_3.tween_property(ability_panel_3, "scale", Vector2(1.0, 1.0), 0.2)
	
	
	await tween_3.finished

	set_panels_interactive(true)



func set_panels_interactive(enabled: bool) -> void:
	var filter = Control.MOUSE_FILTER_STOP if enabled else Control.MOUSE_FILTER_IGNORE
	for panel in [ability_panel, ability_panel_2, ability_panel_3]:
		panel.mouse_filter = filter
		for child in panel.get_children():
			if child is Control:
				child.mouse_filter = filter



func _hide_abilities() -> void:
	ability_panel.hide()
	ability_panel_2.hide()
	ability_panel_3.hide()
