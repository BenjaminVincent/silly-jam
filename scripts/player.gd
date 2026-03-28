extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var projectile: CharacterBody2D = $"."


var projectile_speed = 600
var movement_speed = 100

func _ready() -> void:
	
	animation_player.play("walk_right")
	



func get_input():
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	input_dir.x = 0
	
	velocity = input_dir * movement_speed



func _physics_process(delta):
	
	#get_input()
	
	move_and_collide(self.velocity * delta)
	

func _input(event):
	if event.is_action_pressed("shoot"):
		shoot()

func shoot():
	var projectile = load("res://scenes/projectile.tscn").instantiate()
	
	add_child(projectile)
	
	projectile.global_position = Vector2(global_position.x, global_position.y)
	
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	
	projectile.velocity = direction * projectile_speed
