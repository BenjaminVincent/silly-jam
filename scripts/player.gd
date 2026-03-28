extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var projectile: CharacterBody2D = $"."
@onready var sprite_2d: Sprite2D = $Sprite2D



var projectile_speed = 300
var movement_speed = 100
var spawn_pos = global_position
var horz_limit = 500
var sprite_width = 0

func _ready() -> void:
	
	animation_player.play("walk_right")
	



func get_input():
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#print("player position: " global_position)
	#if global_position.x - spawn_pos.x > horz_limit:
		#input_dir.x = -1
		#print("too far right")
	#elif global_position.x - spawn_pos.x < -horz_limit:
		#input_dir.x = 1
	
	velocity = input_dir * movement_speed



func _physics_process(delta):
	
	get_input()
	
	move_and_collide(self.velocity * delta)
	
	var rect = get_viewport_rect()
	
	global_position = global_position.clamp(rect.position, rect.end)


func _input(event):
	if event.is_action_pressed("shoot"):
		shoot()

func shoot():
	
	var projectile = load("res://scenes/projectile.tscn").instantiate()
	
	get_tree().root.get_node_or_null("Game").add_child(projectile)
	
	projectile.global_position = global_position
	print("shot at: ")
	print(global_position)
	
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	
	projectile.velocity = direction * projectile_speed
