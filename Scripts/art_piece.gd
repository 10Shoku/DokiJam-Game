extends Area2D
class_name ArtPiece

signal piece_clicked(piece : ArtPiece)

var is_correctly_placed := false


func _ready() -> void:
	Dialogic.signal_event.connect(_call_glow)
	input_event.connect(_on_input_event)


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Art Piece clicked at " + str(global_position))
		piece_clicked.emit(self)


func _call_glow(arg : String):
	if arg == "glow art pieces":
		glow()


func glow():
	if is_correctly_placed:
		modulate = Color.RED
	else:
		modulate = Color.GREEN


######################################
###### from interaction_area.gd ######
######################################
### also update in interactable.gd ###
######################################

@onready var phantom_camera : PhantomCamera2D = get_tree().get_first_node_in_group("camera")

@export var dialogue_timeline: String = ""
@export var focus_camera: bool = true
@export var one_time: bool = false

var used: bool = false

func on_interact():
	if one_time and used:
		return
	
	used = true
	if dialogue_timeline != "":
		Dialogic.start(dialogue_timeline)

		if focus_camera:
			phantom_camera.follow_target = self
			Dialogic.timeline_ended.connect(_on_dialogue_end, CONNECT_ONE_SHOT)

func _on_dialogue_end():
	phantom_camera.follow_target = get_tree().get_first_node_in_group("default_camera_target")
