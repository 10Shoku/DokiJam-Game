extends CharacterBody2D

@onready var camera: Camera2D = $Camera2D

@export var speed := 500.0
@export var jump_velocity := -400.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		camera.look_ahead(direction)
		velocity.x = direction * speed
		$AnimatedSprite2D.flip_h = direction > 0
	else:
		camera.look_normal()
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	
