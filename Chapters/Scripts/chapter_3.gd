@tool

extends Node

@onready var doki_statue: ArtPiece = $"World/Display Case/Art Pieces/Doki Statue"
@onready var guns : ArtPiece = $"World/Display Case/Art Pieces/Guns"
@onready var play_button: ArtPiece = $"World/Display Case/Art Pieces/Play Button"
@onready var bl_book: ArtPiece = $"World/Display Case/Art Pieces/BL Book"
@onready var thomas_edison: ArtPiece = $"World/Display Case/Art Pieces/Thomas Edison"
@onready var dad_statue: ArtPiece = $"World/Display Case/Art Pieces/DAD Statue"
@onready var trashcan: ArtPiece = $"World/Display Case/Art Pieces/Trashcan"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	doki_statue.global_position.x = 3592.0
	guns.global_position.x = 4560.0
	play_button.global_position.x = 4040.0
	bl_book.global_position.x = 5032.0
	thomas_edison.global_position.x = 904.0
	dad_statue.global_position.x = 512.0
	trashcan.global_position.x = -8.0
	
	$Doki.can_jump = true
