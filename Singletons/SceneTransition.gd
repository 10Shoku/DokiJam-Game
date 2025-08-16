extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var anim = $AnimationPlayer

var next_scene: String

func change_scene(path: String) -> void:
	next_scene = path
	anim.play("fade_out")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(next_scene)
	anim.play("fade_in")
