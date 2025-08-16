extends Node


func _ready() -> void:
	$Doki.animated_sprite.flip_h = true
	await get_tree().create_timer(0.55).timeout
	Dialogic.start("Mr Man Comic 2")
	
	Dialogic.timeline_ended.connect(_comic_end)


func _comic_end():
	get_tree().change_scene_to_file("res://Chapters/Scenes/chapter_2.tscn")
