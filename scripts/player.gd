extends CharacterBody2D




@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var projectile_speed = 300
var movement_speed = 100
var spawn_pos = global_position
var buffer = Vector2(25, 10)
var inventory: Dictionary = {}
var health = 5
var can_take_damage = true
var dead: bool = false

var level



func _ready() -> void:
	add_to_group("player")
	animation_player.play("walk_right")
	level = get_tree().root.get_node_or_null("Game/level")



func get_input():
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if dead:
		velocity = Vector2.ZERO
		return
	velocity = input_dir * movement_speed



func _input(event):
	
	if dead: return
	
	if event.is_action_pressed("shoot"):
		shoot()



func _physics_process(delta):
	
	get_input()
	
	move_and_collide(self.velocity * delta)
	
	z_index = global_position.y
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		if collision.get_collider().is_in_group("enemies"):
			if can_take_damage: 
				audio_stream_player.play()
				take_damage(1)
	
	var rect = get_viewport_rect()
	var bounds = collision_shape_2d.shape.size + buffer
	
	global_position = global_position.clamp(rect.position + bounds, rect.end - bounds)



func shoot():
	
	var projectile = load("res://scenes/projectile.tscn").instantiate()
	
	get_tree().root.get_node_or_null("Game").add_child(projectile)
	
	projectile.global_position = global_position
	
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	
	projectile.velocity = direction * projectile_speed



func add_to_inventory(item_name, gold) -> void:
	
	if inventory.has(item_name):
		inventory[item_name].quantity += 1
	else:
		inventory[item_name] = { "quantity": 1, "gold": gold }
	
	print("inventory: ", inventory)



func take_damage(value: int) -> void:
	if not can_take_damage: return
	
	can_take_damage = false
	
	animation_player.play("hit")
	audio_stream_player.play()
	health -= value



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"hit":
			if health > 0:
				animation_player.play("walk_right")
				can_take_damage = true
			else:
				dead = true
				level.scroll_speed = 0
				animation_player.play("death")
		"death":
			print("player has died")
