extends Control

@onready var label = $Label


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Score: ", GlobalPlatformer.score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	label.text = "Score: " + str(GlobalPlatformer.score)

func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		print("Game Ended")

func _on_increase_points_pressed():
	GlobalPlatformer.score += 1
	print("points added")


func _on_decrease_points_pressed():
	GlobalPlatformer.score -= 1
	if GlobalPlatformer.score < 0:
		GlobalPlatformer.score = 0
		print("Score changed")
	print("points lost")


func _on_return_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
