extends Area2D

@export var correct_piece : art_piece

var is_movable := true


func _on_body_entered(body: art_piece) -> void:
	print(body.name + " entered Display Area of " + self.name)
	if body == correct_piece:
		lock_piece()


func lock_piece():
	print("piece locked")
	is_movable = false
