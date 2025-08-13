extends CharacterBody2D

signal coins_updated(amount)

@export var speed := 800
@export var gravity := 30
@export var jump_force := 1000
@export var fall_death_offset: float = 3000

@onready var level_settings = "res://Platformer/manager/level_settings.gd"
@onready var level_manager = "res://Platformer/manager/level_manager.gd"

var jump_count = 0
var max_jumps = 2
var coins = 0
var coin_ui: CanvasLayer  # Reference to the UI


func _ready():
	# Method 1: Use groups (ensure UI is in 'coin_ui' group)
	coin_ui = get_tree().get_first_node_in_group("coin_ui")
	level_settings = get_tree().get_first_node_in_group("level_settings")
	level_manager = get_tree().get_first_node_in_group("level_manager")
	
	# Debug test:
	if coin_ui == null:
		print("ERROR: CoinUI not found! Check groups or scene placement.")
	else:
		print("SUCCESS: CoinUI linked!")
		
	update_coin_display()  # Initialize display
	
func _physics_process(delta):
	var screen_bottom = get_viewport_rect().size.y
	var death_line = screen_bottom + LevelManager.get_fall_death_offset()
	var camera = get_viewport().get_camera_2d()
	var camera_bottom = camera.get_screen_center_position().y + camera.get_viewport_rect().size.y / 2
	var animation = $AnimatedSprite2D
	# Debug prints
	#print("Camera Bottom: ", camera_bottom)
	#print("Death Line: ", death_line)
	#print("Player Y: ", global_position.y)
	#
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	
	if is_on_floor():
		jump_count = 0
											#for testing keep this off
											#for real play uncomment it :D
	if Input.is_action_just_pressed("jump") and jump_count < max_jumps:
		velocity.y = -jump_force
		jump_count += 1
	
	
	var h_dir = Input.get_axis("move_left", "move_right")
	
	velocity.x = speed * h_dir
	move_and_slide()
	
	#print(velocity)

	# Debug the critical values
	#print("---")
	#print("Screen Bottom: ", screen_bottom)
	#print("Death Line: ", death_line)
	#print("Player Y: ", global_position.y)
	#print("Should Die: ", global_position.y > death_line)
	#
	if global_position.y > death_line:
		die()

func die():
	var death_sound: AudioStreamPlayer = $DeathSound
	get_tree().paused = true
	print("DEBUG: die() called via death line check")  # <-- Add this
	# Reset player to last checkpoint
	print("Respawning at: ", GlobalPlatformer.checkpoint_position)
	death_sound.play()
	
	# Debug
	await get_tree().create_timer(40)

	get_tree().paused = false
	global_position = GlobalPlatformer.checkpoint_position
	velocity = Vector2.ZERO
	move_and_slide()
	
	# Add death effects (optional)
	
	#$AnimationPlayer.play("respawn_blink")

	
func _unhandled_input(event):
	pass
	#if Input.is_action_just_pressed("pause"):
		#get_tree().quit()
		#print("Game Ended")

func collect_coin():
	GlobalPlatformer.coins += 1
	coins_updated.emit(coins)

func update_coin_display():
	if coin_ui:
		coin_ui.update_coin_display(coins)
