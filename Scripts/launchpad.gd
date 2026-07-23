extends StaticBody3D


func _on_scene_transition_area_body_entered(_body: Node3D) -> void:
	get_tree().call_deferred("change_scene_to_packed", preload("res://Scenes/level1.tscn"))
