extends Node2D

@onready var forground: TileMapLayer = $Forground


var scroll_speed = 40

var rock_tile = Vector2i(14, 2)


func _process(delta):
	forground.position.x -= scroll_speed * delta
	


func _ready() -> void:
	randomize()
	#forground.set_cell(Vector2i(37, 10), 0, Vector2i(14, 2))
	spawn_rocks(60)




func spawn_rocks(n: int) -> void:
	# Y can be between 4, 17
	# X can be between 15, 200
	for i in range(0, n):
		var x_val = randi_range(15, 200)
		var y_val = randi_range(5, 16)
		forground.set_cell(Vector2i(x_val, y_val), 0, rock_tile)
