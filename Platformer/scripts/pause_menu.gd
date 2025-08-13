extends CanvasLayer

func _ready():
	# Access using unique names
	var resume_button = %Resume  # Requires unique name set
	var main_menu_button = %MainMenu
	
	# Alternative path-based access
	#var resume_button = $Panel/VBoxContainer/Resume
	#var main_menu_button = $Panel/VBoxContainer/MainMenu
	
	if resume_button:
		resume_button.pressed.connect(PauseManager.resume_game)
	else:
		print("Resume button path is wrong! Current path: ", get_path_to(resume_button))
	
	if main_menu_button:
		main_menu_button.pressed.connect(PauseManager.return_to_main_menu)
	else:
		print("Main Menu button path is wrong! Current path: ", get_path_to(main_menu_button))
