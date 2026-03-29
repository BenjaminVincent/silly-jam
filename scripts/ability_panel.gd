extends Panel

var tween

@onready var texture_button: TextureButton = $TextureButton
@onready var ability_selection_menu = get_tree().root.get_node("/root/Game/UI/AbilitySelector")

@onready var label: Label = $Label
@onready var description: RichTextLabel = $Description
@onready var icon: Sprite2D = $Icon

@export var ability: Ability


func _ready() -> void:
	if ability:
		label.text = ability.ability_name
		description.text = ability.description
		icon.texture = ability.icon
#
#func _on_mouse_entered() -> void:
	#print("mouse over")
	#tween = create_tween()
	#tween.set_ease(Tween.EASE_OUT)
	##tween.set_trans(Tween.TRANS_QUAD)
	##tween.tween_property(icon, "scale", Vector2(1, 1), 0.33)
	#sprite_2d.scale = Vector2(0.8, 0.8)
	#tween.tween_property(sprite_2d, "scale", Vector2(1.0, 1.0), 0.2)


func _on_texture_button_mouse_entered() -> void:
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	self.scale = Vector2(0.8, 0.8)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.2)


func _on_texture_button_pressed(button) -> void:
	
	var player = get_tree().get_first_node_in_group("player")
	ability_selection_menu._hide_abilities()
	ability_selection_menu.hide()
	player.add_ability(button.get_parent().ability)
	
	get_tree().paused = false
	
	await get_tree().create_timer(6).timeout
	await get_tree().process_frame
	
	player.reset_ability_selector()
