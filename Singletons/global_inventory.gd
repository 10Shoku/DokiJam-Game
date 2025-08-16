extends Node

var items: Dictionary = {}

signal item_added(item_name: String, count: int)
signal item_removed(item_name: String, count: int)


func add_item(item_name: String, count: int = 1) -> void:
	if item_name in items:
		items[item_name] += count
	else:
		items[item_name] = count
	emit_signal("item_added", item_name, items[item_name])


func remove_item(item_name: String, count: int = 1) -> void:
	if item_name in items:
		items[item_name] -= count
		if items[item_name] <= 0:
			items.erase(item_name)
		emit_signal("item_removed", item_name, items.get(item_name, 0))


func has_item(item_name: String, count: int = 1) -> bool:
	return items.has(item_name) and items[item_name] >= count


func list_items() -> Dictionary:
	print(items)
	return items.duplicate()
