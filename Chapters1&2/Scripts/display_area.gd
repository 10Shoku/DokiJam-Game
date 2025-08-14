extends Area2D
class_name DisplayArea

signal is_interacting(it_is : bool)

signal doki_entered(area : DisplayArea)
signal doki_exited(area : DisplayArea)

@export var correct_piece : ArtPiece
@export var current_piece : ArtPiece

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
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("doki"):
		can_interact = true
		doki_entered.emit(self)
	
	elif body is ArtPiece:
		current_piece = body
		print("wait what")
		if body == correct_piece:
			lock_piece(body)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("doki"):
		doki_exited.emit(self)
		can_interact = false
	
	elif body is ArtPiece and body == current_piece:
		print("exited area: ", self, "piece: ", body)
		current_piece = null
