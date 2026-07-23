extends RigidBody2D

@export var gravity: float = 9.8
@export var torque_strength: float = 100.0
@export var fuel: float = 100.0
@export var won: bool = false

func _init() -> void:
	print("Hello, world!")

func _process(_delta: float) -> void:
	if Input.is_action_pressed("Right2D"):
		apply_torque(torque_strength)
	if Input.is_action_pressed("Left2D"):
		apply_torque(-torque_strength)
	if Input.is_action_pressed("Up2D") and fuel > 0.0 and not won:
		apply_force(1000*-transform.y)
		fuel -= _delta
		print(fuel)
		print(-position.y)



func _on_earth_body_exited(body: Node2D) -> void:
	if body == self:
		print("You Win!")
		won = true
