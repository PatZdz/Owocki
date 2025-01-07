extends Node2D
class_name Board

var tile_list: Array = []

func _ready():
	# Wypełniamy tablicę tile_list dziećmi typu Tile
	for node in get_children():
		if node is Tile:
			tile_list.append(node)

	# Debug: sprawdź, ile kafelków znaleziono
	print("[board.gd] tile_list.size() =", tile_list.size())

func get_tile_by_coords(coords: Vector2i) -> Tile:
	for t in tile_list:
		if t.tile_coords == coords:
			return t
	return null
