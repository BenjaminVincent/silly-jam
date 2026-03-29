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
var offset = 600

var wave_0_start_x = 100
var wave_1_start_x = 355
var wave_2_start_x = 368
var wave_3_start_x = 396
var wave_4_start_x = 477

var waves = [
	[ # slimes
		{ "type": "slime",      "cell": Vector2i(49, 14) },
		{ "type": "slime",      "cell": Vector2i(66, 7) },
		{ "type": "slime",      "cell": Vector2i(79, 15) },
		{ "type": "slime",      "cell": Vector2i(90, 9) },
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
		{ "type": "slime", "cell": Vector2i(wave_0_start_x + offset, 9)  },
		{ "type": "slime", "cell": Vector2i(wave_0_start_x + offset, 8) },
		{ "type": "slime",      "cell": Vector2i(wave_0_start_x + offset, 10) },
		{ "type": "slime",      "cell": Vector2i(wave_0_start_x + offset, 7) },
		{ "type": "slime",      "cell": Vector2i(wave_0_start_x + offset, 9) },
		{ "type": "slime", "cell": Vector2i(wave_1_start_x, 7)  },
		{ "type": "slime", "cell": Vector2i(wave_1_start_x, 10) },
		{ "type": "slime", "cell": Vector2i(wave_1_start_x, 8)  },
		{ "type": "slime", "cell": Vector2i(wave_1_start_x, 11)  },
		{ "type": "blue_slime", "cell": Vector2i(wave_1_start_x, 10) },
		{ "type": "blue_slime", "cell": Vector2i(wave_1_start_x, 14) },
		{ "type": "slime",      "cell": Vector2i(wave_1_start_x, 13)  },
		{ "type": "slime", "cell": Vector2i(wave_2_start_x, 8)  },
		{ "type": "slime", "cell": Vector2i(wave_2_start_x, 10) },
		{ "type": "blue_slime", "cell": Vector2i(wave_2_start_x, 14) },
		{ "type": "slime",      "cell": Vector2i(wave_2_start_x, 8)  },
		{ "type": "blue_slime", "cell": Vector2i(wave_2_start_x, 9)  },
		{ "type": "blue_slime", "cell": Vector2i(wave_2_start_x, 10) },
		{ "type": "blue_slime", "cell": Vector2i(wave_2_start_x, 14) },
		{ "type": "slime",      "cell": Vector2i(wave_2_start_x, 8)  },
		{ "type": "blue_slime", "cell": Vector2i(wave_3_start_x, 6)  },
		{ "type": "blue_slime", "cell": Vector2i(wave_3_start_x, 10) },
		{ "type": "blue_slime", "cell": Vector2i(wave_3_start_x, 14) },
		{ "type": "slime",      "cell": Vector2i(wave_3_start_x, 8)  },
		{ "type": "blue_slime", "cell": Vector2i(wave_3_start_x, 6)  },
		{ "type": "blue_slime", "cell": Vector2i(wave_3_start_x, 10) },
		{ "type": "blue_slime", "cell": Vector2i(wave_3_start_x, 14) },
		{ "type": "slime",      "cell": Vector2i(wave_3_start_x, 8)  },
		{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 9)  },
		{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 11) },
		{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 14) },
		{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 8)  },
		{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 7)  },
		{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 10) },
		{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 12) },
		{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 8)  },
		{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 8)  },
		{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 10) },
		{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 13) },
		{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 8)  },
	]
	#[ # wave 0
		#{ "type": "slime", "cell": Vector2i(wave_0_start_x + offset, 9)  },
		#{ "type": "slime", "cell": Vector2i(wave_0_start_x + offset, 8) },
		#{ "type": "slime",      "cell": Vector2i(wave_0_start_x + offset, 10) },
		#{ "type": "slime",      "cell": Vector2i(wave_0_start_x + offset, 7) },
		#{ "type": "slime",      "cell": Vector2i(wave_0_start_x + offset, 9) },
	#],
	#[ # wave 1
		#{ "type": "slime", "cell": Vector2i(wave_1_start_x, 7)  },
		#{ "type": "slime", "cell": Vector2i(wave_1_start_x, 10) },
		#{ "type": "slime", "cell": Vector2i(wave_1_start_x, 8)  },
		#{ "type": "slime", "cell": Vector2i(wave_1_start_x, 11)  },
		#{ "type": "blue_slime", "cell": Vector2i(wave_1_start_x, 10) },
		#{ "type": "blue_slime", "cell": Vector2i(wave_1_start_x, 14) },
		#{ "type": "slime",      "cell": Vector2i(wave_1_start_x, 13)  },
	#],
	#[ # wave 2
		#{ "type": "slime", "cell": Vector2i(wave_2_start_x, 8)  },
		#{ "type": "slime", "cell": Vector2i(wave_2_start_x, 10) },
		#{ "type": "blue_slime", "cell": Vector2i(wave_2_start_x, 14) },
		#{ "type": "slime",      "cell": Vector2i(wave_2_start_x, 8)  },
		#{ "type": "blue_slime", "cell": Vector2i(wave_2_start_x, 9)  },
		#{ "type": "blue_slime", "cell": Vector2i(wave_2_start_x, 10) },
		#{ "type": "blue_slime", "cell": Vector2i(wave_2_start_x, 14) },
		#{ "type": "slime",      "cell": Vector2i(wave_2_start_x, 8)  },
	#],
	#[ # wave 3
		#{ "type": "blue_slime", "cell": Vector2i(wave_3_start_x, 6)  },
		#{ "type": "blue_slime", "cell": Vector2i(wave_3_start_x, 10) },
		#{ "type": "blue_slime", "cell": Vector2i(wave_3_start_x, 14) },
		#{ "type": "slime",      "cell": Vector2i(wave_3_start_x, 8)  },
		#{ "type": "blue_slime", "cell": Vector2i(wave_3_start_x, 6)  },
		#{ "type": "blue_slime", "cell": Vector2i(wave_3_start_x, 10) },
		#{ "type": "blue_slime", "cell": Vector2i(wave_3_start_x, 14) },
		#{ "type": "slime",      "cell": Vector2i(wave_3_start_x, 8)  },
	#],
	#[ # wave 4
		#{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 9)  },
		#{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 11) },
		#{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 14) },
		#{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 8)  },
		#{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 7)  },
		#{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 10) },
		#{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 12) },
		#{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 8)  },
		#{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 8)  },
		#{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 10) },
		#{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 13) },
		#{ "type": "blue_slime", "cell": Vector2i(wave_4_start_x, 8)  },
	
]

func _ready() -> void:
	randomize()
	forground.add_to_group("forground")
	
	wave_thresholds = [
		-forground.to_global(forground.map_to_local(Vector2i(wave_0_start_x, 0))).x,
		-forground.to_global(forground.map_to_local(Vector2i(wave_1_start_x, 0))).x,
		-forground.to_global(forground.map_to_local(Vector2i(wave_2_start_x, 0))).x,
		-forground.to_global(forground.map_to_local(Vector2i(wave_3_start_x, 0))).x,
		-forground.to_global(forground.map_to_local(Vector2i(wave_4_start_x, 0))).x,
	]
	
	level_one_cell_choords = forground.map_to_local(Vector2i(200, 0))
	level_one_global_end = forground.to_global(level_one_cell_choords)
	ability_selector_screen = get_parent().get_node("UI/AbilitySelector")
	spawn_wave(0)

func _process(delta):
	forground.position.x -= GlobalStatics.scroll_speed * delta
	secondary_forground.position.x -= GlobalStatics.scroll_speed * delta
	
	if current_wave < wave_thresholds.size():
		if forground.position.x < wave_thresholds[current_wave]:
			current_wave += 1
			spawn_wave(current_wave)

func spawn_wave(index: int):
	if index >= waves.size():
		print("all waves complete")
		return
	print("spawning wave: ", index)
	for entry in waves[index]:
		spawn_enemy_at(entry.type, entry.cell)

func spawn_enemy_at(type: String, cell: Vector2i):
	var path = "res://scenes/enemies/" + type + ".tscn"
	var enemy = load(path).instantiate()
	var local_pos = background.map_to_local(cell)
	var global_pos = background.to_global(local_pos)
	enemy.position = global_pos
	add_child(enemy)
