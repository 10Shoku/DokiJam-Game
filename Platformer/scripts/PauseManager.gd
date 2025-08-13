extends Node

var pause_menu_scene = preload("res://Pause Menu/pause_menu.tscn")
var pause_menu_instance = null

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	var tree = get_tree()
	if tree.paused:
		resume_game()
	else:
		pause_game()

func pause_game():
	if pause_menu_instance: return
	
	get_tree().paused = true
	pause_menu_instance = pause_menu_scene.instantiate()
	get_tree().root.add_child(pause_menu_instance)
	
	# Ensure buttons receive focus
	await get_tree().process_frame
	if pause_menu_instance.has_node("%Resume"):
		pause_menu_instance.get_node("%Resume").grab_focus()

func resume_game():
	if not pause_menu_instance: return
	
	get_tree().paused = false
	pause_menu_instance.queue_free()
	pause_menu_instance = null

func return_to_main_menu():
	resume_game()
	get_tree().change_scene_to_file("res://Main Menu/main_menu.tscn")
