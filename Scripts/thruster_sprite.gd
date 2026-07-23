extends Sprite2D

var is_dragging = false
var mouse_offset
var delay = 10

func _physics_process(delta: float) -> void:
	if is_dragging:
		var tween = get_tree().create_tween()
		tween.tween_property(get_parent(), "position", get_global_mouse_position(), delay * delta)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print(get_rect())
			print(to_local(event.position))
			if get_rect().has_point(to_local(event.position)):
				print("Clicked on sprite!")
			print("down")
			is_dragging = true
		else:
			print("up")
			is_dragging = false
			get_parent().linear_velocity = Vector2(0, 0)

func _process(delta: float) -> void:
	pass
	#if is_dragging:
		#get_parent().global_position = get_global_mouse_position()
