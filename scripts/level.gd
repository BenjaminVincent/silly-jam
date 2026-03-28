extends Node2D

@onready var forground: TileMapLayer = $Forground


var scroll_speed = 20

func _process(delta):
	forground.position.x -= scroll_speed * delta
	
