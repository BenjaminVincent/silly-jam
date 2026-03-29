extends TextureButton

@onready var overlay: ColorRect = $Overlay
@onready var cooldown_label: Label = $Cooldown

func _ready() -> void:
	overlay.hide()
	cooldown_label.hide()

#func start_cooldown(duration: float, cooldown: float) -> void:
	#overlay.show()
	#cooldown_label.show()
	#
	## count down through duration + cooldown
	#var total = duration + cooldown
	#var elapsed = 0.0
	#
	#while elapsed < total:
		#elapsed += get_process_delta_time()
		#var remaining = total - elapsed
		#cooldown_label.text = "%d" % remaining
		#
		## darker while active, lighter during cooldown
		#if elapsed < duration:
			#overlay.color = Color(0, 0, 0, 0.3)  # active tint
		#else:
			#overlay.color = Color(0, 0, 0, 0.6)  # cooldown tint
		#
		#await get_tree().process_frame
	#
	#overlay.hide()
	#cooldown_label.hide()


func start_cooldown(duration: float, cooldown: float) -> void:
	overlay.show()
	cooldown_label.show()
	
	var elapsed = 0.0
	
	# duration phase
	cooldown_label.add_theme_color_override("font_color", Color.RED)
	overlay.color = Color(0, 0, 0, 0.3)
	while elapsed < duration:
		elapsed += get_process_delta_time()
		cooldown_label.text = "%d" % int(duration - elapsed)
		await get_tree().process_frame
	
	elapsed = 0.0
	
	# cooldown phase
	cooldown_label.add_theme_color_override("font_color", Color.WHITE)
	overlay.color = Color(0, 0, 0, 0.6)
	while elapsed < cooldown:
		elapsed += get_process_delta_time()
		cooldown_label.text = "%d" % int(cooldown - elapsed)
		await get_tree().process_frame
	
	overlay.hide()
	cooldown_label.hide()
