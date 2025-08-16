extends Node

@onready var trashcan_area: DisplayArea = $Trashcan
@onready var dad_statue_area: DisplayArea = $"DAD Statue"
@onready var thomas_edison_area: DisplayArea = $"Thomas Edison"
@onready var doki_statue_area: DisplayArea = $"Doki Statue"
@onready var play_button_area: DisplayArea = $"Play Button"
@onready var guns_area: DisplayArea = $Guns
@onready var bl_book_area: DisplayArea = $"BL Book"

#@onready var doki_statue: ArtPiece = $"Art Pieces/Doki Statue"
#@onready var guns: ArtPiece = $"Art Pieces/Guns"
#@onready var play_button: ArtPiece = $"Art Pieces/Play Button"
#@onready var bl_book: ArtPiece = $"Art Pieces/BL Book"
#@onready var thomas_edison: ArtPiece = $"Art Pieces/Thomas Edison"
#@onready var dad_statue: ArtPiece = $"Art Pieces/DAD Statue"
#@onready var trashcan: ArtPiece = $"Art Pieces/Trashcan"

var doki_current_areas : Array[DisplayArea] = []


func _ready() -> void:
	for area : DisplayArea in get_tree().get_nodes_in_group("display_area"):
		area.doki_entered.connect(_on_doki_entered)
		area.doki_exited.connect(_on_doki_exited)
	
	for piece : ArtPiece in get_tree().get_nodes_in_group("art_piece"):
		piece.piece_clicked.connect(_on_piece_clicked)


func _on_doki_entered(area : DisplayArea):
	if area not in doki_current_areas:
		doki_current_areas.append(area)
	#print("\nEntering...")
	#print("Current Area: " + str(area))
	#print("Current Piece: " + str(area.current_piece))


func _on_doki_exited(area : DisplayArea):
	#print("\nExiting...")
	#print("Current Area: " + str(area))
	#print("Current Piece: " + str(area.current_piece))
	doki_current_areas.erase(area)


func get_current_area() -> DisplayArea:
	if doki_current_areas.size() > 0:
		return doki_current_areas[-1]
	
	return null


## recheck what items are in each display case
#func update_case_info():
	#pass
#
#
#func swap_pieces(from: DisplayArea, to: DisplayArea):
	#if from.current_piece == null or to.current_piece == null:
		#print("One of the areas has no piece to swap.")
		#return
	#
	##var artpiece_swap_var : ArtPiece = null
	##
	#print("\nBefore swap:\n\tCurrent Piece: " + str(from.current_piece) + "\n\tSwap With: " + str(to.current_piece))
	##artpiece_swap_var = from.current_piece
	##from.current_piece = to.current_piece
	##to.current_piece = artpiece_swap_var
	#
	#var position_swap_var := Vector2.ZERO
	#
	#position_swap_var = from.current_piece.global_position
	#from.current_piece.global_position = to.current_piece.global_position
	#to.current_piece.global_position = position_swap_var
	#print("After swap:\n\tCurrent Piece: " + str(from.current_piece) + "\n\tSwap With: " + str(to.current_piece))
	#
	#print("\n\nSwap " + str(from) + " and " + str(to) + "\n\n")
	#
	##update_case_info()
 #
#
#
#func _on_piece_clicked(piece : ArtPiece):
	#if doki_current_areas.is_empty():
		#print("\nDoki not in any area")
		#return
	#
	#var from_area = get_current_area()
	#
	#print("\n-----------------------------------\nPiece to swap with: " + str(piece))
	#match piece:
		#doki_statue:
			#swap_pieces(from_area, trashcan_area)
		#guns:
			#swap_pieces(from_area, dad_statue_area)
		#play_button:
			#swap_pieces(from_area, thomas_edison_area)
		#bl_book:
			#swap_pieces(from_area, doki_statue_area)
		#thomas_edison:
			#swap_pieces(from_area, play_button_area)
		#dad_statue:
			#swap_pieces(from_area, guns_area)
		#trashcan:
			#swap_pieces(from_area, bl_book_area)


func get_area_of_piece(piece: ArtPiece) -> DisplayArea:
	for area in get_tree().get_nodes_in_group("display_area"):
		if area.current_piece == piece:
			return area
	return null


func swap_pieces(from: DisplayArea, to: DisplayArea):
		if from == null or to == null or from == to:
			print("Invalid swap")
			return

		print("\nSwapping", from, "with", to)

		# Swap current_piece
		var temp_piece: ArtPiece = from.current_piece
		from.current_piece = to.current_piece
		to.current_piece = temp_piece

		# Swap positions
		var temp_pos: float = from.current_piece.global_position.x
		from.current_piece.global_position.x = to.current_piece.global_position.x
		to.current_piece.global_position.x = temp_pos
		
		Dialogic.dialogic_paused


func _on_piece_clicked(piece: ArtPiece):
	var from_area = get_current_area()
	var to_area = get_area_of_piece(piece)

	if from_area == null or to_area == null or from_area == to_area:
		print("Cannot swap:", from_area, to_area)
		return

	swap_pieces(from_area, to_area)
