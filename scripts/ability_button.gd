extends TextureButton

@onready var overlay: ColorRect = $Overlay
@onready var cooldown_label: Label = $Cooldown

func _ready() -> void:
	overlay.hide()
	cooldown_label.hide()

func start_cooldown(duration: float, cooldown: float) -> void:
	overlay.show()
	cooldown_label.show()
	
	# count down through duration + cooldown
	var total = duration + cooldown
	var elapsed = 0.0
	
	while elapsed < total:
		elapsed += get_process_delta_time()
		var remaining = total - elapsed
		cooldown_label.text = "%d" % remaining
		
		# darker while active, lighter during cooldown
		if elapsed < duration:
			overlay.color = Color(0, 0, 0, 0.3)  # active tint
		else:
			overlay.color = Color(0, 0, 0, 0.6)  # cooldown tint
		
		await get_tree().process_frame
	
	overlay.hide()
	cooldown_label.hide()
