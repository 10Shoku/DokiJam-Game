extends Camera2D

@onready var doki: CharacterBody2D = $".."

@export var zoom_in := Vector2(2.5, 2.5)
@export var zoom_out := Vector2(1.5, 1.5)
@export var zoom_speed := 5.0

@export var camera_speed := 3.0

var dialogue_in_progress := false

var looking_up := false
var looking_down := false
var looking_direction := 0


func _ready() -> void:
	SignalBus.display_dialog.connect(on_display_dialog)
	SignalBus.dialogue_end.connect(on_dialogue_end)


func _process(delta: float) -> void:
	var target_zoom = zoom_in if dialogue_in_progress else zoom_out
	zoom = zoom.lerp(target_zoom, delta * zoom_speed)
	
	if looking_direction != 0:
		offset.x = lerpf(offset.x, looking_direction * 100, camera_speed * delta)
	else:
		offset.x = lerpf(offset.x, 0, camera_speed * delta)
	
	if looking_up:
		offset.y = lerpf(offset.y, -150.0, camera_speed * delta)
	elif looking_down:
		offset.y = lerpf(offset.y, 150.0, camera_speed * delta)
	else:
		offset.y = lerpf(offset.y, 0.0, camera_speed * delta)


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("look_up"):
		looking_up = true
	if Input.is_action_just_released("look_up"):
		looking_up = false
	
	if Input.is_action_just_pressed("look_down"):
		looking_down = true
	if Input.is_action_just_released("look_down"):
		looking_down = false


func look_ahead(direction : int):
	looking_direction = direction


func look_normal():
	looking_direction = 0


func on_display_dialog(dialogue_key):
	dialogue_in_progress = true


func on_dialogue_end():
	dialogue_in_progress = false
