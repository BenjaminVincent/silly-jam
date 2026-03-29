extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer




@export var loot_drop: Item
@export var health = 2
@export var speed = 30
@export var drop_chance = 0.5
@export var push_back = 50

var loot
var player
var can_take_damage = true
var follow_delay = 0.05
var dead = false


func _ready() -> void:

	add_to_group("enemies")

	
	animation_player.play("walk_left")
	player = get_tree().get_first_node_in_group("player")
	velocity.x = -speed



func _physics_process(delta):
	
	move_and_collide(self.velocity * delta)
	
	z_index = int(global_position.y)
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		if collision.get_collider().is_in_group("player"):
			player.hit_by_enemy = true

	if dead:
		velocity.y = 0
		velocity.x = -40 # Speed of the level
	elif player:
		var direction = (player.global_position - global_position).normalized()
		velocity = lerp(velocity, direction * speed, follow_delay)
	
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
	
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = -direction * push_back



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	
	match anim_name:
		"hit":
			if health <= 0:
				animation_player.play("death")
				can_take_damage = false
				dead = true
				
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
		get_parent().add_child(loot)
		
	queue_free()
