extends CharacterBody2D

var tween
var speed = 100

func _ready() -> void:
	tween = create_tween()
	
	tween.tween_property(self, "rotation", 90, 6)

func get_input():
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	input_dir.x = 0
	
	velocity = input_dir * speed



func _physics_process(delta):
	
	get_input()
	
	move_and_collide(velocity * delta)
	
	#var rect = get_viewport_rect()
	
	#global_position = global_position.clamp(rect.position, rect.end - collision_shape_2d.shape.size)
