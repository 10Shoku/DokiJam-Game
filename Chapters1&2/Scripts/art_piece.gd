extends TextureRect
class_name ArtPiece

var is_correctly_placed := false


func _ready() -> void:
	Dialogic.signal_event.connect(_call_glow)


func _call_glow(arg : String):
	if arg == "glow art pieces":
		glow()


func glow():
	if is_correctly_placed:
		self_modulate = Color.RED
	else:
		self_modulate = Color.GREEN
