# Checkpoint.gd
extends Area2D

@onready var sprite = $Sprite2D
var activated = false

func _ready():
	# Connect signal automatically
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if not activated and body.is_in_group("player"):  # Better than name check
		activated = true
		print("Checkpoint activated. Player position BEFORE: ", body.global_position)
		GlobalPlatformer.checkpoint_position = global_position
		print("Checkpoint SAVED at: ", GlobalPlatformer.checkpoint_position)  # <-- Add this
		print("Checkpoint activated. Player position AFTER: ", body.global_position)
	#if not activated and body.name == "player":
		#activate()

func activate():
	activated = true
	Global.checkpoint_position = global_position
	sprite.frame = 1  # Change to flag-up texture
	#$ActivationSound.play()  # Optional sound effect
