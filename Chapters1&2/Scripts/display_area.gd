extends Area2D
class_name DisplayArea

signal is_interacting(it_is : bool)

@export var correct_piece : ArtPiece

var is_movable := true
var can_interact := false

func _ready():
	Dialogic.timeline_started.connect(_on_timeline_started)
	Dialogic.timeline_ended.connect(_on_timeline_ended)


func _on_timeline_started():
	is_interacting.emit(true)
	can_interact = false


func _on_timeline_ended():
	is_interacting.emit(false)
	can_interact = true


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and can_interact:
		Dialogic.start("art_piece_swap")


func lock_piece(body: ArtPiece):
	print("piece locked")
	is_movable = false
	body.is_correctly_placed = true


# gotta make the swap functionality first
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("doki"):
		can_interact = true
	
	if body is ArtPiece:
		print(body, correct_piece)
		if body == correct_piece:
			lock_piece(body)


func _on_body_exited(body: CharacterBody2D) -> void:
	if body.is_in_group("doki"):
		can_interact = false
