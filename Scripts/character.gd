extends CharacterBody3D

@export_category("Movement")
@export var max_speed := 20.0
@export var acceleration := 0.02
@export var jump_strength := 20.0
@export var gravity := 1.0
@export_category("Camera")
@export var mouse_sensitivity := 2.0

var mouse_movement : Vector2

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _physics_process(_delta: float) -> void:
	# Creates a 2D vector which stores the direction the player is accelerating in
	var target_velocity = Vector2.ZERO
	if Input.is_action_pressed("Forward3D"):
		target_velocity += Vector2.UP
	if Input.is_action_pressed("Backward3D"):
		target_velocity += Vector2.DOWN
	if Input.is_action_pressed("Left3D"):
		target_velocity += Vector2.LEFT
	if Input.is_action_pressed("Right3D"):
		target_velocity += Vector2.RIGHT
	target_velocity = target_velocity.normalized() * max_speed
	
	# interpolates between the current and intended velocity seperately for each direction (directions are in the player's reference frame)
	var x_velocity : Vector3 = basis.x * lerp(basis.x.dot(velocity), target_velocity.x, acceleration)
	var y_velocity : Vector3 = basis.y * (basis.y.dot(velocity) - gravity) # I'm sure this is inefficient by whatevs :3
	# This is where jumping is added too
	if Input.is_action_just_pressed("Jump3D") and $GroundDetector.has_overlapping_bodies():
		y_velocity += basis.y * jump_strength
	var z_velocity : Vector3 = basis.z * lerp(basis.z.dot(velocity), target_velocity.y, acceleration)
	
	# Finally combines them all.
	velocity = x_velocity + y_velocity + z_velocity
	move_and_slide()
	# Other behaviours that have to happen every frame
	fix_rotation()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_movement = event.relative

func fix_rotation() -> void:
	var turning = mouse_movement.x * -0.001 * mouse_sensitivity
	mouse_movement = Vector2.ZERO
	var up_dir = global_position.normalized()
	var backward_dir = global_transform.basis.z.slide(up_dir).normalized()
	
	backward_dir = backward_dir.rotated(up_dir, turning) # turning
	
	var right_dir = up_dir.cross(backward_dir)
	basis.y = up_dir
	basis.z = backward_dir
	basis.x = right_dir
	up_direction = up_dir
	#$XIndicator.look_at(global_position+right_dir)
	#$YIndicator.look_at(global_position+up_dir, Vector3.RIGHT)
	#$ZIndicator.look_at(global_position+backward_dir)
	#basis = basis.orthonormalized()

func animate_camera() -> void:
	pass
	#TODO: Come back to me!
	#$Camera3D.position = initial_camera_pos + lerp()
