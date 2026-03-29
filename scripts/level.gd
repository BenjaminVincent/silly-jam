extends Node2D

@onready var forground: TileMapLayer = $Forground
@onready var background: TileMapLayer = $Background
@onready var secondary_forground: TileMapLayer = $SecondaryForground

var rock_tile = Vector2i(14, 2)
var level_one_cell_choords
var level_one_global_end
var ability_selector_screen
var level_one_ended: bool = false
var current_wave = 0

var wave_thresholds = []

var wave_0_start_x = 215
var wave_one_start_x = 66
var wave_two_start_x = 80
var wave_three_start_x = 120

var waves = [
	[ # slimes
		{ "type": "slime",      "cell": Vector2i(49, 14) },
		{ "type": "slime",      "cell": Vector2i(66, 7) },
		{ "type": "slime",      "cell": Vector2i(79, 15) },
		{ "type": "slime",      "cell": Vector2i(101, 7) },
		{ "type": "slime",      "cell": Vector2i(115, 7) },
		{ "type": "slime",      "cell": Vector2i(115, 8) },
		{ "type": "slime",      "cell": Vector2i(135, 9) },
		{ "type": "slime",      "cell": Vector2i(157, 13) },
		{ "type": "slime",      "cell": Vector2i(157, 14) },
		{ "type": "slime",      "cell": Vector2i(182, 5) },
		{ "type": "slime",      "cell": Vector2i(192, 15) },
		{ "type": "slime",      "cell": Vector2i(215, 6) },
		{ "type": "slime",      "cell": Vector2i(215, 9) },
		{ "type": "slime",      "cell": Vector2i(242, 15) },
	],
	[ # wave 0
		{ "type": "slime", "cell": Vector2i(wave_0_start_x, 4)  },
		{ "type": "slime", "cell": Vector2i(wave_0_start_x, 5) },
		{ "type": "slime",      "cell": Vector2i(wave_0_start_x, 6) },
		{ "type": "slime",      "cell": Vector2i(wave_0_start_x, 7) },
		{ "type": "slime",      "cell": Vector2i(wave_0_start_x, 9) },
	],
	[ # slime 9

	],
	[ # slime 8

	],
	[ # wave 3
		#{ "type": "blue_slime", "cell": Vector2i(wave_three_start_x, 6)  },
		#{ "type": "blue_slime", "cell": Vector2i(wave_three_start_x, 10) },
		#{ "type": "blue_slime", "cell": Vector2i(wave_three_start_x, 14) },
		#{ "type": "slime",      "cell": Vector2i(wave_three_start_x, 8)  },
		#{ "type": "blue_slime", "cell": Vector2i(wave_three_start_x, 6)  },
		#{ "type": "blue_slime", "cell": Vector2i(wave_three_start_x, 10) },
		#{ "type": "blue_slime", "cell": Vector2i(wave_three_start_x, 14) },
		#{ "type": "slime",      "cell": Vector2i(wave_three_start_x, 8)  },
	],
]



func _ready() -> void:
	randomize()
	forground.add_to_group("forground")
	
	wave_thresholds = [
		-forground.to_global(forground.map_to_local(Vector2i(wave_one_start_x, 0))).x,
		-forground.to_global(forground.map_to_local(Vector2i(wave_two_start_x, 0))).x,
		-forground.to_global(forground.map_to_local(Vector2i(wave_three_start_x, 0))).x,
	]
	
	level_one_cell_choords = forground.map_to_local(Vector2i(200, 0))
	level_one_global_end = forground.to_global(level_one_cell_choords)
	ability_selector_screen = get_parent().get_node("UI/AbilitySelector")
	spawn_next_wave()  # kicks off wave 1 on start



func _process(delta):
	forground.position.x -= GlobalStatics.scroll_speed * delta
	secondary_forground.position.x -= GlobalStatics.scroll_speed * delta
	
	if current_wave < wave_thresholds.size():
		if forground.position.x < wave_thresholds[current_wave]:
			current_wave += 1
			spawn_next_wave()




func spawn_next_wave():
	
	if current_wave >= waves.size():
		print("all waves complete")
		return
	
	for entry in waves[current_wave]:
		spawn_enemy_at(entry.type, entry.cell)
		await get_tree().create_timer(0.8).timeout



func spawn_enemy_at(type: String, cell: Vector2i):
	var path = "res://scenes/enemies/" + type + ".tscn"
	var enemy = load(path).instantiate()
	var local_pos = background.map_to_local(cell)
	var global_pos = background.to_global(local_pos)
	enemy.position = global_pos
	add_child(enemy)
