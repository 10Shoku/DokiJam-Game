extends Control

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Chapter1/chapter_1.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Main-Menu/options_menu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
