extends Control

@onready var ability_panel: Panel = $HBoxContainer/AbilityPanel
@onready var ability_panel_2: Panel = $HBoxContainer/AbilityPanel2
@onready var ability_panel_3: Panel = $HBoxContainer/AbilityPanel3


var tween_1
var tween_2
var tween_3


var skip_panel_1: bool = false
var skip_panel_2: bool = false
var skip_panel_3: bool = false

func show_with_tween(abilities) -> void:

	if abilities:
		for ability in abilities:
			if ability.ability_name == "Speed Boost":
				skip_panel_1 = true
			if ability.ability_name == "Strong-Arm":
				skip_panel_2 = true
			if ability.ability_name == "Wave Clear":
				skip_panel_3 = true
	modulate.a = 0.0
	show()

	set_panels_interactive(false)

	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.3)

	await get_tree().create_timer(1.2).timeout
	await get_tree().process_frame
	
	
	
	if not skip_panel_1:
		ability_panel.scale = Vector2(0.0, 0.0)
		ability_panel.show()
		tween_1 = create_tween()
		tween_1.set_ease(Tween.EASE_OUT)
		ability_panel.scale = Vector2(0.8, 0.8)
		tween_1.tween_property(ability_panel, "scale", Vector2(1.0, 1.0), 0.2)
		await get_tree().create_timer(0.6).timeout
		await get_tree().process_frame
	
	if not skip_panel_2:
		ability_panel_2.scale = Vector2(0.0, 0.0)
		ability_panel_2.show()
		tween_2 = create_tween()
		tween_2.set_ease(Tween.EASE_OUT)
		ability_panel_2.scale = Vector2(0.8, 0.8)
		tween_2.tween_property(ability_panel_2, "scale", Vector2(1.0, 1.0), 0.2)

		await get_tree().create_timer(0.6).timeout
		await get_tree().process_frame
	
	if not skip_panel_3:
		ability_panel_3.scale = Vector2(0.0, 0.0)
		ability_panel_3.show()
		tween_3 = create_tween()
		tween_3.set_ease(Tween.EASE_OUT)
		ability_panel_3.scale = Vector2(0.8, 0.8)
		tween_3.tween_property(ability_panel_3, "scale", Vector2(1.0, 1.0), 0.2)

	#await tween_3.finished
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
