extends Control

@onready var panel: TextureRect = $Panel

var panels = [
	"res://Chapters/Comic Panels/Intro/panel1.png",
	"res://Chapters/Comic Panels/Intro/panel2.png",
]
var index = 0


func _ready():
	panel.texture = load(panels[index])


func _on_next_pressed():
	next_page()


func _on_previous_pressed() -> void:
	prev_page()


# on inputs too. use left, right arrows maybe


func next_page():
	index += 1
	if index < panels.size():
		panel.texture = load(panels[index])
	else:
		get_tree().change_scene("res://Scenes/Chapter1.tscn")


func prev_page():
	index -= 1
	if index < 0:
		pass
