extends Line2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_point(Vector2.ZERO)
	add_point(Vector2.ZERO)



func _process(delta: float) -> void:
	var mouse_pos = get_local_mouse_position()
	set_point_position(points.size() - 1, mouse_pos)
