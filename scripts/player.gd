extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var player_hit: AudioStreamPlayer = $player_hit
@onready var game_over_sound: AudioStreamPlayer = $game_over
@onready var game = get_tree().root.get_node("/root/Game")
@onready var end = get_tree().root.get_node("/root/Game/UI/End")
@onready var ability_UI = get_tree().root.get_node("/root/Game/UI/AbilityUi")
@onready var game_over_panel = get_tree().root.get_node("/root/Game/UI/game_over_panel")
@onready var health_ui = get_tree().root.get_node("/root/Game/UI/HealthUi")


@export var health = 3
@export var movement_speed = 50
@export var fire_rate = 0.2
@export var off_screen_death_threshold = 32

@export var abilities: Array[Ability] = []


# For abilities
var stored_base_move_speed
var ability_1_ready: bool = true
var ability_2_ready: bool = true
var projectile_scale = 1.0
var stored_base_projectile_scale
var base_damage = 1
var stored_base_damage


var projectile_speed = 300
var spawn_pos = global_position
var buffer = Vector2(25, 10)
var inventory: Dictionary = {}
var can_take_damage = true
var dead: bool = false
var hit_by_enemy = false
var shot_ready = true

var level

var end_line_top = Vector2i(15, 0)
var end_line_middle = Vector2i(15, 1)
var end_line_bottom = Vector2i(16, 1)

var blue_rug_top = Vector2i(6, 0)
var blue_rug_middle = Vector2i(6, 1)
var blue_rug_bottom = Vector2i(7, 1)



var ability_selector_shown: bool = false
var end_screen_shown: bool = false

func _ready() -> void:
	add_to_group("player")
	animation_player.play("walk_right")
	level = get_tree().root.get_node_or_null("Game/level")
	health_ui._init_health_ui(health)


func get_input():
	
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if Input.is_action_pressed("shoot") && shot_ready:
		shoot()
		shot_ready = false
		await get_tree().create_timer(fire_rate).timeout
		await get_tree().process_frame
		shot_ready = true
		
		
	velocity = input_dir.normalized() * movement_speed



func _input(event):
	if dead:
		return
	if event.is_action_pressed("ability_1") and abilities.size() >= 1 and ability_1_ready:
		ability_1_ready = false  # block immediately on press
		use_ability(abilities[0])
		_start_ability_timers(abilities[0], 1)
	if event.is_action_pressed("ability_2") and abilities.size() >= 2 and ability_2_ready:
		ability_2_ready = false  # block immediately on press
		use_ability(abilities[1])
		_start_ability_timers(abilities[1], 2)




func use_ability(ability) -> void:
	match ability.ability_name:
		"Speed Boost":
			_speed_boost()
		"Strong-Arm":
			_strong_arm()
		"Wave Clear":
			_wave_clear()


func _speed_boost() -> void:
	stored_base_move_speed = movement_speed
	movement_speed =  (movement_speed * 2) + movement_speed
	print("new movement_speed: ", movement_speed)

func _strong_arm() -> void:
	print("inside strong arm")
	stored_base_projectile_scale = projectile_scale
	stored_base_damage = base_damage
	projectile_scale = 2
	base_damage = 2
	pass



func _wave_clear() -> void:
	var viewport_rect = get_viewport_rect()
	
	for enemy in get_tree().get_nodes_in_group("enemies"):
		if viewport_rect.has_point(enemy.global_position):
			enemy.take_damage(999)



func _start_ability_timers(ability, slot: int) -> void:
	
	var buttons = ability_UI.h_box_container.get_children()
	if slot - 1 < buttons.size():
		buttons[slot - 1].start_cooldown(ability.duration, ability.cooldown)
	
	await get_tree().create_timer(ability.duration).timeout
	_end_ability(ability)
	
	await get_tree().create_timer(ability.cooldown).timeout
	if slot == 1:
		ability_1_ready = true
	else:
		ability_2_ready = true
	print(ability.ability_name, " ready!")



func _end_ability(ability) -> void:
	match ability.ability_name:
		"Speed Boost":
			movement_speed = stored_base_move_speed  # restore speed
		"Strong-Arm":
			projectile_scale = stored_base_projectile_scale
			base_damage = stored_base_damage




func _physics_process(delta):
	
	z_index = clampi(int(global_position.y), -4096, 4096)
	
	if !dead:
		get_input()
	
		var collision = move_and_collide(velocity * delta)
		
		var forground = get_tree().get_first_node_in_group("forground")
		if forground:
			var tile_pos = forground.local_to_map(forground.to_local(global_position))
			var atlas_coords = forground.get_cell_atlas_coords(tile_pos)
			
			if not ability_selector_shown and (atlas_coords == end_line_top or atlas_coords == end_line_middle or atlas_coords == end_line_bottom):
				ability_selector_shown = true
				get_tree().paused = true
				game.get_node("UI/AbilitySelector").show_with_tween(abilities)
			
			if not end_screen_shown and (atlas_coords == blue_rug_top or atlas_coords == blue_rug_middle or atlas_coords == blue_rug_bottom):
				end_screen_shown = true
				#get_tree().paused = true
				end.get_score(inventory)
				end.show()
				
			
	
		
		if can_take_damage && (collision && collision.get_collider().is_in_group("enemies") || hit_by_enemy):
			player_hit.play()
			take_damage(1)
		
		var rect = get_viewport_rect()
		var bounds = collision_shape_2d.shape.size + buffer
		
		global_position = global_position.clamp(rect.end * -1  , rect.end - bounds)
	
	if global_position.x < -off_screen_death_threshold:
		_death()
		queue_free()




func reset_ability_selector():
	print("RESETTING ABILITY SELECTOR")
	ability_selector_shown = false




func shoot():
	
	var projectile = load("res://scenes/projectile.tscn").instantiate()
	
	get_tree().root.get_node_or_null("Game").add_child(projectile)
	
	projectile.global_position = global_position
	projectile.scale = Vector2(projectile.scale.x * projectile_scale, projectile.scale.y * projectile_scale)
	projectile.damage = base_damage
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	
	projectile.velocity = direction * projectile_speed
	



func add_to_inventory(item_name, gold) -> void:
	
	if inventory.has(item_name):
		inventory[item_name].quantity += 1
	else:
		inventory[item_name] = { "quantity": 1, "gold": gold }




func take_damage(value: int) -> void:
	if not can_take_damage: return
	
	can_take_damage = false
	hit_by_enemy = false
	set_collision_mask_value(2, false)
	set_collision_layer_value(1, false)
	
	
	animation_player.play("hit")
	player_hit.play()
	health -= value
	health_ui._update_health_ui(health)



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"hit":
			if health > 0:
				animation_player.play("walk_right")
				can_take_damage = true
				set_collision_mask_value(2, true)
				set_collision_layer_value(1, true)
			else:
				_death()
				animation_player.play("death")
		"death":
			pass



func _death() -> void:
	dead = true
	GlobalStatics.scroll_speed = 0
	game_over_sound.play()
	game_over_panel.show()


func add_ability(ability) -> void:
	abilities.append(ability)
	#
	#print("abilities: ", abilities)
	for a in abilities:
		print("name: ", a.ability_name)
	ability_UI.update_abilities(abilities)
