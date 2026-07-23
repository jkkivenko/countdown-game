extends Label

@onready var initial_position := position

func _process(_delta: float) -> void:
	if CountdownController.time_left <= 5.0:
		label_settings.font_size = lerp(42, 75, (5 - CountdownController.time_left) / 5)
		var jitter_amount = lerp(0.5, 1.0, (5 - CountdownController.time_left) / 5)
		position.x = initial_position.x + jitter_amount * 1 * sin(CountdownController.time_left * 160)
		position.y = initial_position.y + jitter_amount * 2 * sin(CountdownController.time_left * 200)
	text = "T-"+str(int(ceil(CountdownController.time_left)))
