extends CharacterBody2D

@onready var camera: Camera2D = $Camera2D
@onready var interaction_detector: CollisionShape2D = $InteractionDetector/CollisionShape2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
# sprite sheet still has a few messed up pixels. fix after jam

@export var speed := 500.0
@export var jump_velocity := -800.0

# disable jump in level 1 pre-rube-goldberg-event
var can_jump := false
var is_interacting := false

@export var auto_walk_time := 0.5
var walk_timer := 0.0
@export var auto_walk_speed := speed

var idp : float


func _ready() -> void:
	walk_timer = auto_walk_time
	
	idp = -interaction_detector.position.x
	
	Dialogic.timeline_started.connect(_timeline_started)
	Dialogic.timeline_ended.connect(_timeline_ended)
	
	for area in get_tree().get_nodes_in_group("display_area"):
		area.is_interacting.connect(_interaction_movement_lock)


func _timeline_started():
	animated_sprite.play("idle")
	_interaction_movement_lock(true)


func _timeline_ended():
	_interaction_movement_lock(false)


func _interaction_movement_lock(interacting_state : bool):
	is_interacting = interacting_state


func _physics_process(delta: float) -> void:
	if is_interacting:
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite.play("air")

	if Input.is_action_just_pressed("jump") and can_jump and is_on_floor():
		velocity.y = jump_velocity

	var direction := Input.get_axis("move_left", "move_right")
	
	if walk_timer > 0:
		velocity.x = auto_walk_speed
		walk_timer -= delta
		animated_sprite.play("walk")
		animated_sprite.flip_h = true
	
	else:
		if direction:
			camera.look_ahead(direction)
			velocity.x = direction * speed
			
			interaction_detector.position.x = idp * direction
			
			if animated_sprite.animation != "air" or is_on_floor():
				animated_sprite.play("walk")
			
			animated_sprite.flip_h = direction > 0
		else:
			camera.look_normal()
			velocity.x = move_toward(velocity.x, 0, speed)
			
			if animated_sprite.animation != "air" or is_on_floor():
				animated_sprite.play("idle")

	move_and_slide()


func _unhandled_input(event):
	if event.is_action_pressed("interact"):
		GlobalInventory.list_items()
		for area in $InteractionDetector.get_overlapping_areas():
			if area.has_method("on_interact"):
				area.on_interact()
				return
