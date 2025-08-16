extends Control

func _ready():
	var main_menu_music: AudioStreamPlayer = $MainMenuOST
	main_menu_music.play()
	

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Chapters/Scenes/comic_intro.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menu/settings.tscn")


func _on_achievements_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menu/achievements.tscn")


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menu/credits.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
