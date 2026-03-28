extends Node2D
@onready var level: Node2D = $level

@onready var cursor: Sprite2D = $UI/Cursor


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _process(_delta: float) -> void:
	cursor.position = get_global_mouse_position()
