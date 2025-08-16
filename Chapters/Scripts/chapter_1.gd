extends Node


func _ready() -> void:
	await get_tree().create_timer(0.55).timeout
	Dialogic.start("intro")
	Dialogic.signal_event.connect(_area_1_end)


func _area_1_end(arg : String):
	if arg == "Area 1 end":
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://Chapters/Scenes/comic_2.tscn")
