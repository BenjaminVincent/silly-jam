extends Node2D
@onready var level: Node2D = $level

@onready var cursor: Sprite2D = $UI/Cursor


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _process(_delta: float) -> void:
	cursor.position = get_global_mouse_position()




func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo and (event.keycode == KEY_ESCAPE):
		_on_pressed()



func _on_pressed() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
