extends CanvasLayer

@export_file("*.json") var dialogue_file: String

@onready var not_doki_name_label: RichTextLabel = $"Not Doki/Not Doki Sprite/Panel/NotDokiNameLabel"
@onready var doki_sprite: TextureRect = $"Doki/Doki Sprite"
@onready var not_doki_sprite: TextureRect = $"Not Doki/Not Doki Sprite"
@onready var dialogue_label: Label = $"Dialogue Box/Dialogue Frame/Dialogue Text"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var dialogue_text := {}
var selected_text := []
var in_progress = false


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
	var text_to_show : String = selected_text.pop_front()
	
	if text_to_show.begins_with("Doki"):
		doki_turn()
	else:
		not_doki_turn()
	
	dialogue_label.text = text_to_show


func next_line():
	if selected_text.size() > 0:
		show_text()
	else:
		finish()


func finish():
	dialogue_label.text = ""
	
	animation_player.play("dialogue_end")
	await animation_player.animation_finished
	
	SignalBus.dialogue_end.emit()
	visible = false
	in_progress = false
	get_tree().paused = false


func on_display_dialog(dialogue_key):
	doki_sprite["modulate"] = Color(0x7a7a7aff)
	not_doki_sprite["modulate"] = Color(0x7a7a7aff)
	
	if in_progress:
		next_line()
	
	else:
		get_tree().paused = true
		
		visible = true
		not_doki_sprite.texture = load(dialogue_text[dialogue_key]["sprite_path"])
		animation_player.play("dialogue_start")
		await animation_player.animation_finished
		in_progress = true
		
		not_doki_name_label.text = dialogue_text[dialogue_key]["name"]
		selected_text = dialogue_text[dialogue_key]["lines"].duplicate()
		
		show_text()


func doki_turn():
	doki_sprite["modulate"] = Color(1, 1, 1, 1)


func not_doki_turn():
	not_doki_sprite["modulate"] = Color(1, 1, 1, 1)
