extends Area2D
class_name ArtPiece

signal piece_clicked(piece : ArtPiece)

var is_correctly_placed := false


func _ready() -> void:
	Dialogic.signal_event.connect(_call_glow)
	input_event.connect(_on_input_event)


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		piece_clicked.emit(self)


func _call_glow(arg : String):
	if arg == "glow art pieces":
		glow()


func glow():
	if is_correctly_placed:
		self_modulate = Color.RED
	else:
		self_modulate = Color.GREEN
