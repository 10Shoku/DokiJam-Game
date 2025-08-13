extends Node

@onready var doki_statue: ArtPiece = $"Art Pieces/Doki Statue"
@onready var guns: ArtPiece = $"Art Pieces/Guns"
@onready var play_button: ArtPiece = $"Art Pieces/Play Button"
@onready var bl_book: ArtPiece = $"Art Pieces/BL Book"
@onready var thomas_edison: ArtPiece = $"Art Pieces/Thomas Edison"
@onready var dad_statue: ArtPiece = $"Art Pieces/DAD Statue"
@onready var trashcan: ArtPiece = $"Art Pieces/Trashcan"


func _ready() -> void:
	swap_pieces(doki_statue, guns)


func swap_pieces(from : ArtPiece, to : ArtPiece):
	var swap_var
	
	swap_var = from.global_position
	from.global_position = to.global_position
	to.global_position = swap_var


#func _on_doki_statue_button_pressed() -> void:
	#swap_pieces(, doki_statue)
#
#
#func _on_guns_button_pressed() -> void:
	#swap_pieces(, guns)
#
#
#func _on_play_button_button_pressed() -> void:
	#swap_pieces(, play_button)
#
#
#func _on_bl_book_button_pressed() -> void:
	#swap_pieces(, bl_book)
#
#
#func _on_thomas_edison_button_pressed() -> void:
	#swap_pieces(, thomas_edison)
#
#
#func _on_dad_statue_button_pressed() -> void:
	#swap_pieces(, dad_statue)
#
#
#func _on_trashcan_button_pressed() -> void:
	#swap_pieces(, trashcan)
