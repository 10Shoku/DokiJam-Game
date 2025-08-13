extends Node2D

@export var offset := Vector2(0, -320)
@export var duration := 5.0

func _ready():
	start_tween()
	
func start_tween():
	var tween = get_tree().create_tween()
	tween.set_loops(0)
	tween.set_parallel(false)
	tween.tween_property($AnimatableBody2D, "position", offset, duration / 2)
	tween.tween_property($AnimatableBody2D, "position", Vector2.ZERO, duration / 2)
