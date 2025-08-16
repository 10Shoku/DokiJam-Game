extends Area2D

signal start_combat

@export var required_item := "Wingman/Gun"

func on_interact():
	if GlobalInventory.has_item(required_item):
		print("Correct item used!")
	else:
		print("Wrong item! Lose HP")

	start_combat.emit()
