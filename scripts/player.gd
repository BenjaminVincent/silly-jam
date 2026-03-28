extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


var projectile_speed = 300
var movement_speed = 100
var spawn_pos = global_position
var buffer = Vector2(25, 10)


func _ready() -> void:
	
	animation_player.play("walk_right")



func get_input():
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	velocity = input_dir * movement_speed


func _physics_process(delta):
	
	get_input()
	
	move_and_collide(self.velocity * delta)
	
	var rect = get_viewport_rect()
	var bounds = collision_shape_2d.shape.size + buffer
	
	global_position = global_position.clamp(rect.position + bounds, rect.end - bounds)


func _input(event):
	if event.is_action_pressed("shoot"):
		shoot()


func shoot():
	
	var projectile = load("res://scenes/projectile.tscn").instantiate()
	
	get_tree().root.get_node_or_null("Game").add_child(projectile)
	
	projectile.global_position = global_position
	
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	
	projectile.velocity = direction * projectile_speed
