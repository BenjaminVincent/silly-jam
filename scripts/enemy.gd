extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var speed = 50

func _ready() -> void:
	add_to_group("enemies")
	animation_player.play("walk_left")
	velocity.x = -speed



func _physics_process(delta):
	move_and_collide(self.velocity * delta)



	if position.x < - 32:
		queue_free()
