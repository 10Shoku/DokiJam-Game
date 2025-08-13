extends Node

var score: int
var current_score: int = 0
var high_score: int

var coins: int

var checkpoint_position: Vector2 = Vector2.ZERO  # <-- Add this


#func _input(event):
	#if event.is_action_pressed("pause"):
		#PauseMenu.toggle_pause()  # Toggle via the global singleton
