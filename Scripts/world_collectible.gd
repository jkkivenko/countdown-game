@tool
extends Node3D

@export var collectible : Collectible:
	set(new):
		collectible = new
		clear_3d_model()
		if collectible and collectible.model:
			call_deferred("load_3d_model", collectible.model)
@export var pickup_radius := 5.0:
	set(new):
		pickup_radius = new
		$PlayerDetector/CollisionShape3D.shape.radius = pickup_radius

var time_counter = 0.0

func _on_player_detector_body_entered(_body: Node3D) -> void:
	Collectibles.collected.append(collectible)
	$Particles.emitting = true
	$Pivot.visible = false
	$PlayerDetector.visible = false

func _on_particles_finished() -> void:
	if not Engine.is_editor_hint():
		queue_free()

func clear_3d_model():
	for child in $Pivot.get_children():
		child.queue_free()

func load_3d_model(model : PackedScene):
	print("instantiating 3d model")
	var node = model.instantiate()
	$Pivot.add_child(node)
	if Engine.is_editor_hint():
		node.owner = get_tree().edited_scene_root

func _process(delta: float) -> void:
	$Pivot.rotation.y += 0.05 # yippee magic numbers!! :D
	$Pivot.position.y = sin(5 * time_counter)
	time_counter += delta
