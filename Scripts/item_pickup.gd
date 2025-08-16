extends Area2D

@export var item_name: String = "Default"
@export var count: int = 1

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("doki"):
		GlobalInventory.add_item(item_name, count)
		queue_free()
