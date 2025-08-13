extends CanvasLayer

func _ready():
	# Access using unique names
	var resume_button = $"HBoxContainer/Menu Options/VBoxContainer/MarginContainer/Continue"  # Requires unique name set
	var main_menu_button = $"HBoxContainer/Menu Options/VBoxContainer/MarginContainer5/MainMenu"
	
	if resume_button:
		resume_button.pressed.connect(PauseManager.resume_game)
	else:
		print("Resume button path is wrong! Current path: ", get_path_to(resume_button))
	
	if main_menu_button:
		main_menu_button.pressed.connect(PauseManager.return_to_main_menu)
	else:
		print("Main Menu button path is wrong! Current path: ", get_path_to(main_menu_button))


func _on_continue_pressed() -> void:
	return


func _on_save_pressed() -> void:
	pass # Replace with function body.


func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_achievements_pressed() -> void:
	pass # Replace with function body.


func _on_main_menu_pressed():
	pass # Replace with function body.
