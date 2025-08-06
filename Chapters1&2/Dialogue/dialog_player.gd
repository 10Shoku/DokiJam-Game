extends CanvasLayer

@export_file("*.json") var dialogue_file: String

var dialogue_text := {}
var selected_text := []
var in_progress = false

@onready var background: TextureRect = $Background
@onready var text_label: Label = $Components/TextLabel
@onready var name_label: RichTextLabel = $Components/NameLabel
@onready var sprite: Sprite2D = $Components/Sprite2D


func _ready() -> void:
	visible = false
	dialogue_text = load_dialogue_text()
	SignalBus.display_dialog.connect(on_display_dialog)


func load_dialogue_text() -> Dictionary:
	if dialogue_file == "":
		push_error("No dialogue_file set!")
		return {}
	
	var file = FileAccess.open(dialogue_file, FileAccess.READ)
	if not file:
		push_error("Failed to open file: %s" % dialogue_file)
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
	visible = false
	in_progress = false
	get_tree().paused = false


func on_display_dialog(dialogue_key):
	if in_progress:
		next_line()
	else:
		get_tree().paused = true
		visible = true
		in_progress = true
		name_label.text = dialogue_text[dialogue_key]["name"]
		sprite.texture = load(dialogue_text[dialogue_key]["sprite_path"])
		selected_text = dialogue_text[dialogue_key]["lines"].duplicate()
		show_text()
