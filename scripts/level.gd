extends Node2D

@onready var forground: TileMapLayer = $Forground
@onready var background: TileMapLayer = $Background


var scroll_speed = 40

var rock_tile = Vector2i(14, 2)


func _process(delta):
	forground.position.x -= scroll_speed * delta
	


func _ready() -> void:
	randomize()
	#forground.set_cell(Vector2i(37, 10), 0, Vector2i(14, 2))
	#spawn_rocks(60)
	spawn_enemy(4)



func spawn_enemy(n: int, time_between: float = 0.8):
	
	for i in range(0, n):
		
		var enemy = load("res://scenes/enemy.tscn").instantiate()
		
		var y_val = randi_range(5, 16)
		var x_val = randi_range(41, 43)
		
		var cell_coords = Vector2(x_val, y_val)
		
		var local_pos = background.map_to_local(cell_coords)
		var global_pos = background.to_global(local_pos)
		
		enemy.position = global_pos
		
		add_child(enemy)
		
		await get_tree().create_timer(time_between).timeout
		await get_tree().process_frame



func spawn_rocks(n: int) -> void:
	for i in range(0, n):
		var x_val = randi_range(15, 200)
		var y_val = randi_range(5, 16)
		forground.set_cell(Vector2i(x_val, y_val), 0, rock_tile)
