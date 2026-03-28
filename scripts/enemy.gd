extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@export var loot_drop: Item
@export var health = 3
@export var speed = 30
@export var drop_chance = 0.5

var loot

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
	
	can_take_damage = false
	
	animation_player.play("hit")
	audio_stream_player.play()
	health -= value
	
	var tween = create_tween()
	
	tween.tween_property(self, "scale", Vector2(1.8, 0.8), 0.15)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_BACK)



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
		loot.loot_data = loot_drop
		print("item dropping: ", loot.loot_data)
		get_parent().add_child(loot)
		
	queue_free()
