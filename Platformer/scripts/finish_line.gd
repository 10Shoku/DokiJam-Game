extends Area2D

@export var next_scene: String = ""  # Set this in the inspector per finish line
@onready var sprite_2d = $Sprite2D
var activated = false

func _ready():
	# Connect signal automatically
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if not activated and body.is_in_group("player"):  # Better than name check
		activated = true
		activate()  # Visual feedback
		await get_tree().create_timer(0.5).timeout  # Brief delay for animation
		LevelManager.change_scene(next_scene)
		GlobalPlatformer.coins = 0
		#LevelManager.change_scene()
		#get_tree().change_scene_to_file("res://scenes/level_2.tscn")

func activate():
	# Add visual/audio effects here
	sprite_2d.frame = 1  # Change to activated sprite frame
	#$AnimationPlayer.play("activate")
	#$ConfettiParticles.emitting = true
	#$VictorySound.play()
