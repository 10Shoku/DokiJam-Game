extends Area2D

@export var dialogue_timeline: String = ""
@export var focus_camera: bool = true
@export var one_time: bool = false
@onready var phantom_camera: PhantomCamera2D = $PhantomCamera2D

var used: bool = false

func on_interact():
	if one_time and used:
		return
	
	used = true
	if dialogue_timeline != "":
		Dialogic.start(dialogue_timeline)

		if focus_camera:
			phantom_camera.set_follow_target(self)
			Dialogic.timeline_ended.connect(_on_dialogue_end, CONNECT_ONE_SHOT)

func _on_dialogue_end():
	phantom_camera.set_follow_target(get_tree().get_first_node_in_group("Player"))
