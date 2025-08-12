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
