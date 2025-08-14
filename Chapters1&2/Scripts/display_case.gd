extends Node

@onready var trashcan_area: DisplayArea = $Trashcan
@onready var dad_statue_area: DisplayArea = $"DAD Statue"
@onready var thomas_edison_area: DisplayArea = $"Thomas Edison"
@onready var doki_statue_area: DisplayArea = $"Doki Statue"
@onready var play_button_area: DisplayArea = $"Play Button"
@onready var guns_area: DisplayArea = $Guns
@onready var bl_book_area: DisplayArea = $"BL Book"

@onready var doki_statue: ArtPiece = $"Art Pieces/Doki Statue"
@onready var guns: ArtPiece = $"Art Pieces/Guns"
@onready var play_button: ArtPiece = $"Art Pieces/Play Button"
@onready var bl_book: ArtPiece = $"Art Pieces/BL Book"
@onready var thomas_edison: ArtPiece = $"Art Pieces/Thomas Edison"
@onready var dad_statue: ArtPiece = $"Art Pieces/DAD Statue"
@onready var trashcan: ArtPiece = $"Art Pieces/Trashcan"

var current_area : DisplayArea


func _ready() -> void:
	for piece : ArtPiece in get_tree().get_nodes_in_group("art_piece"):
		piece.piece_clicked.connect(_on_piece_clicked)


func get_current_area() -> DisplayArea:
	for area : DisplayArea in get_tree().get_nodes_in_group("display_area"):
		for body in area.get_overlapping_bodies():
			if body.is_in_group("doki"):
				print("Current Area: " + str(area))
				print("Current Piece: " + str(area.current_piece))
				return area
	
	return null


# recheck what items are in each display case
func update_case_info():
	pass


func swap_pieces(from: DisplayArea, to: DisplayArea):
	var artpiece_swap_var : ArtPiece
	
	print("\nBefore swap:\n\tCurrent Piece: " + str(from.current_piece) + "\n\tSwap With: " + str(to.current_piece))
	artpiece_swap_var = from.current_piece
	from.current_piece = to.current_piece
	to.current_piece = artpiece_swap_var
	print("After swap:\n\tCurrent Piece: " + str(from.current_piece) + "\n\tSwap With: " + str(to.current_piece))
	
	var position_swap_var : Vector2
	
	position_swap_var = from.current_piece.global_position
	from.current_piece.global_position = to.current_piece.global_position
	to.current_piece.global_position = position_swap_var
	
	update_case_info()
 


func _on_piece_clicked(piece : ArtPiece):
	var from_area = get_current_area()
	if from_area == null:
		print("\nWarning: Doki not found in any display area!")
		return
	
	print("\n-----------------------------------\nPiece to swap with: " + str(piece))
	match piece:
		doki_statue:
			swap_pieces(from_area, trashcan_area)
		guns:
			swap_pieces(from_area, dad_statue_area)
		play_button:
			swap_pieces(from_area, thomas_edison_area)
		bl_book:
			swap_pieces(from_area, doki_statue_area)
		thomas_edison:
			swap_pieces(from_area, play_button_area)
		dad_statue:
			swap_pieces(from_area, guns_area)
		trashcan:
			swap_pieces(from_area, bl_book_area)
