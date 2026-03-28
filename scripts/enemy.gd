extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var speed = 30

var health = 3

var can_take_damage = true

var drop_chance = 0.99

var loot


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
	
	can_take_damage = false
	
	animation_player.play("hit")
	
	health -= value



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	
	match anim_name:
		"hit":
			if health <= 0:
				animation_player.play("death")
				can_take_damage = false
				velocity.x = -40 # Speed of the level
			else:
				can_take_damage = true
				animation_player.play("walk_left")
		"death":
			_death()


func _death() -> void:
	if randf() < drop_chance:
		loot = load("res://scenes/loot.tscn").instantiate()
		loot.position = position
		print("item dropping!")
		get_parent().add_child(loot)
		
	queue_free()
