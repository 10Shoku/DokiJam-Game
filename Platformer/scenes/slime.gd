extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
@onready var vision = $vision
@onready var collision_shape_2d = $CollisionShape2D
const PLAYER = preload("res://Platformer/scenes/player.tscn")

@export var player: CharacterBody2D
@export var speed = 50
@export var chase_speed = 150
@export var acceleration = 300

@onready var ray_cast_2d = $AnimationPlayer/RayCast2D
@onready var timer = $Timer

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2
var right_bounds: Vector2
var left_bounds: Vector2

var alert: bool = false

enum States{
	WANDER,
	CHASE
}

var current_state = States.WANDER
#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#
#
#func _physics_process(delta):
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()

func _ready():
	animation_player.play("idle")
	left_bounds = self.position + Vector2(-125, 0)
	right_bounds = self.position + Vector2(125, 0)

func _physics_process(delta):
	handle_gravity(delta)
	handle_movement(delta)
	#animation_player.seek(randf_range(0, animation_player.current_animation_length))

func handle_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
func handle_movement(delta):
	pass
	#if current_state == States.WANDER:
		#velocity = velocity.move_toward(direction + speed, acceleration * delta)
	#else:
		#velocity = velocity.move_toward(direction + chase_speed, acceleration * delta)	
	#
	#move_and_slide()
func change_direction():
	if current_state == States.WANDER:
		if sprite_2d.flip_h:
			# moving right
			if self.position.x <= right_bounds.x:
				direction = Vector2(1, 0)
			else:
				# flip to moving left
				sprite_2d.flip_h = false
				ray_cast_2d.target_position = Vector2(-125, 0)
		else:
			# moving left
			if self.position.x >= left_bounds.x:
				direction = Vector2(-1, 0)
			else:
				# flip to moving right
				sprite_2d.flip_h = true
				ray_cast_2d.target_position = Vector2(125, 0)
	else:
		# Chase state, follow player
		direction = (player.position - self.position).normalized()
		direction = sign(direction)
		if direction.x == 1:
			# flip to moving right
			sprite_2d.flip_h = true
			ray_cast_2d.target_position = Vector2(125, 0)
		else:
			# flip to moving left
			sprite_2d.flip_h = false
			ray_cast_2d.target_position = Vector2(-125, 0)
	
func look_for_player():
	if ray_cast_2d.is_colliding():
		var collider = ray_cast_2d.get_collider()
		if collider == player:
			chase_player()
		elif current_state == States.CHASE:
			stop_chase()
	elif current_state == States.CHASE:
		stop_chase()

func chase_player():
	timer.stop()
	current_state = States.CHASE
	
func stop_chase():
	if timer.time_left <= 0:
		timer.start()


	
func _on_timer_timeout():
	current_state = States.WANDER
