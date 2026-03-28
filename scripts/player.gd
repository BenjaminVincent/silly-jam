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
	

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		shoot()
		


func shoot():
	var p = projectile.instantiate()
	add_child(p)
	p.transform = $Muzzle.transform
