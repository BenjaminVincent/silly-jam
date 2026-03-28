extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var speed = 50

var health = 3

var can_take_damage = true

func _ready() -> void:
	add_to_group("enemies")
	animation_player.play("walk_left")
	velocity.x = -speed



func _physics_process(delta):
	move_and_collide(self.velocity * delta)



	if position.x < - 32:
		queue_free()



func take_damage(value: int) -> void:
	
	if not can_take_damage: return
	
	animation_player.play("hit")
	
	health -= value



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	
	match anim_name:
		"hit":
			if health <= 0:
				print("enemy has died")
				animation_player.play("death")
				can_take_damage = false
				velocity.x = -40
			else:
				animation_player.play("walk_left")
		"death":
			queue_free()
	
	
