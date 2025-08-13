extends Node

signal scene_change_started(scene_path)
signal scene_change_finished(scene_path)
signal loading_progress_updated(progress)

@export var level_config: LevelConfig  # Assign .tres file here
@export var fade_color := Color.BLACK
@export var fade_duration := 0.5
@export var min_loading_time := 1.0


var _target_path : String
var _wait_frames := 0
var _current_scene : Node
var _loading_screen : Control
var current_level := 1
var level_order := [
	"res://Platformer/scenes/level_1.tscn",
	"res://Platformer/scenes/level_2.tscn",
	"res://Platformer/scenes/level_3.tscn"
]

func _ready():
	var root = get_tree().root
	_current_scene = root.get_child(root.get_child_count() - 1)
	_create_fade_layer()

func get_fall_death_offset() -> float:
	var fall_death_offset: float = 3000
	return fall_death_offset

func change_levels():
	get_tree().change_scene_to_file("res://Platformer/scenes/level_2.tscn")
	
func change_scene(path: String, use_loading_screen := true) -> void:
	_target_path = path
	emit_signal("scene_change_started", _target_path)
	
	if use_loading_screen:
		_show_loading_screen()
		if ResourceLoader.load_threaded_request(_target_path) != OK:
			push_error("Failed to start loading scene: ", _target_path)
			return
		_wait_frames = 1
	else:
		_perform_transition(_target_path)

	
func _process(_delta: float) -> void:
	if _target_path.is_empty(): return
	
	if _wait_frames > 0:
		_wait_frames -= 1
		return

	var progress := []
	var status = ResourceLoader.load_threaded_get_status(_target_path, progress)
	
	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			emit_signal("loading_progress_updated", progress[0])
			_update_loading_screen(progress[0])
		
		ResourceLoader.THREAD_LOAD_LOADED:
			var scene = ResourceLoader.load_threaded_get(_target_path)
			_hide_loading_screen()
			_perform_transition(_target_path, scene)
			_target_path = ""
		
		ResourceLoader.THREAD_LOAD_FAILED:
			push_error("Error loading scene: %s" % _target_path)
			_target_path = ""
	
func _perform_transition(path: String, scene: PackedScene = null) -> void:
	# Fade out animation
	#await _fade_animation(1.0).finished
	
	# Load scene if not already loaded
	if scene == null:
		scene = load(path)
		if not scene is PackedScene:
			push_error("Invalid scene file: " + path)
			return
	
	# Scene transition
	var new_scene = scene.instantiate()
	get_tree().root.add_child(new_scene)
	get_tree().current_scene = new_scene
	_current_scene.queue_free()
	_current_scene = new_scene
	
	# Fade in animation
	#await _fade_animation(0.0).finished
	
	emit_signal("scene_change_finished", path)
	
func _create_fade_layer() -> void:
	var fade = ColorRect.new()
	fade.name = "FadeLayer"
	fade.color = fade_color
	fade.visible = false
	fade.z_index = 1000  # Always on top
	var canvas = CanvasLayer.new()
	canvas.layer = 100
	canvas.add_child(fade)
	add_child(canvas)

#func _fade_animation(target_alpha: float) -> Tween:
	#var fade = get_node("CanvasLayer/FadeLayer")
	#fade.visible = true
	#var tween = create_tween()
	#tween.tween_property(fade, "modulate:a", target_alpha, fade_duration)
	#return tween

func load_next_level():
	current_level = wrapi(current_level + 1, 0, level_order.size())
	change_scene(level_order[current_level])

func restart_current_level():
	change_scene(level_order[current_level])

func _show_loading_screen() -> void:
	if has_node("%LoadingScreen"):
		get_node("%LoadingScreen").visible = true

func _update_loading_screen(progress: float) -> void:
	if has_node("%ProgressBar"):
		get_node("%ProgressBar").value = progress * 100

func _hide_loading_screen() -> void:
	if has_node("%LoadingScreen"):
		get_node("%LoadingScreen").visible = false
