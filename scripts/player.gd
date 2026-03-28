extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var projectile: CharacterBody2D = $"."


var speed = 100



func _ready() -> void:
	
	animation_player.play("walk_right")
	



func get_input():
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	input_dir.x = 0
	
	velocity = input_dir * speed



func _physics_process(delta):
	
	get_input()
	
	move_and_collide(velocity * delta)
	
