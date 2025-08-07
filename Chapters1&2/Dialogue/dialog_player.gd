extends CanvasLayer

@export_file("*.json") var dialogue_file: String

var dialogue_text := {}
var selected_text := []
var in_progress = false

@onready var camera: Camera2D = $Background

@onready var not_doki_name_label: RichTextLabel = $"Not Doki/Panel/NotDokiNameLabel"
@onready var not_doki_sprite: Sprite2D = $"Not Doki/Not Doki Sprite"
@onready var dialogue_label: Label = $"Dialogue Box/Dialogue Frame/Dialogue Text"


func _ready() -> void:
	camera.enabled = false
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
	dialogue_label.text = selected_text.pop_front()


func next_line():
	if selected_text.size() > 0:
		show_text()
	else:
		finish()


func finish():
	dialogue_label.text = ""
	camera.enabled = false
	visible = false
	in_progress = false
	get_tree().paused = false


func on_display_dialog(dialogue_key):
	if in_progress:
		next_line()
	else:
		get_tree().paused = true
		camera.enabled = true
		visible = true
		in_progress = true
		not_doki_name_label.text = dialogue_text[dialogue_key]["name"]
		not_doki_sprite.texture = load(dialogue_text[dialogue_key]["sprite_path"])
		selected_text = dialogue_text[dialogue_key]["lines"].duplicate()
		show_text()
