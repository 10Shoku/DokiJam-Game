extends CharacterBody2D

@onready var camera: Camera2D = $Camera2D

@export var speed := 500.0
@export var jump_velocity := -400.0

# disable jump in level 1 pre-rube-goldberg-event
var can_jump := false
var is_interacting := false


func _ready() -> void:
	for area in get_tree().get_nodes_in_group("display_area"):
		area.is_interacting.connect(_interaction_movement_lock)


func _interaction_movement_lock(interacting_state : bool):
	is_interacting = interacting_state


func _physics_process(delta: float) -> void:
	if is_interacting:
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and can_jump and is_on_floor():
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
	
