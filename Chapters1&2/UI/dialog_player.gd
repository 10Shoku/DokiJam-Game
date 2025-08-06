extends CanvasLayer

@export_file("*.json") var scene_text_file: String

var scene_text = {}
var selected_text = []
var in_progress = false

@onready var background: TextureRect = $Background
@onready var text_label: Label = $TextLabel


func _ready() -> void:
	print((JSON))
	background.visible = false
	scene_text = load_scene_text()
	SignalBus.display_dialog.connect(on_display_dialog)


func load_scene_text() -> Dictionary:
	if scene_text_file == "":
		push_error("No scene_text_file set!")
		return {}
	
	var file = FileAccess.open(scene_text_file, FileAccess.READ)
	if not file:
		push_error("Failed to open file: %s" % scene_text_file)
		return {}
	
	var content = file.get_as_text()
	file.close()
	
	var parsed = JSON.parse_string(content)
	if typeof(parsed) != TYPE_DICTIONARY:
		push_error("JSON parse failed or data is not a Dictionary")
		return {}
	return parsed


func show_text():
	text_label.text = selected_text.pop_front()


func next_line():
	if selected_text.size() > 0:
		show_text()
	else:
		finish()


func finish():
	text_label.text = ""
	background.visible = false
	in_progress = false
	get_tree().paused = false


func on_display_dialog(text_key):
	if in_progress:
		next_line()
	else:
		get_tree().paused = true
		background.visible = true
		in_progress = true
		selected_text = scene_text[text_key].duplicate()
		show_text()
