###################################
### also update in art_piece.gd ###
###################################

extends Area2D
class_name Interactable

signal interacted(interactable: Interactable)
signal start_combat(interactable: Interactable)
signal item_picked(interactable: Interactable)

@onready var phantom_camera : PhantomCamera2D = get_tree().get_first_node_in_group("camera")

# General
@export_enum("dialogue", "item", "combat") var type: String = "dialogue"
@export var one_time: bool = false
var used: bool = false

# Dialogue
@export var dialogue_timeline: String = ""
@export var focus_camera: bool = true

# Item
@export var item_name: String = ""


func on_interact():
	if one_time and used:
		return
	used = true

	match type:
		"dialogue":
			_start_dialogue()
		"item":
			_give_item()
		"combat":
			_trigger_combat()


# -----------------
# Type Behaviours
# -----------------

func _start_dialogue():
	if dialogue_timeline == "":
		return
	Dialogic.start(dialogue_timeline)

	if focus_camera:
		phantom_camera.follow_target = get_parent()
		Dialogic.timeline_ended.connect(_on_dialogue_end, CONNECT_ONE_SHOT)


func _on_dialogue_end():
	phantom_camera.follow_target = get_tree().get_first_node_in_group("default_camera_target")
	interacted.emit(self)


func _give_item():
	if item_name == "":
		return
	print("Picked up: %s" % item_name)
	GlobalInventory.add_item(item_name)
	item_picked.emit(self)
	queue_free()

func _trigger_combat():
	print("Combat triggered!")
	start_combat.emit(self)
