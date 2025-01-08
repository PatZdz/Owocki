extends Node2D
class_name Board

var tile_list: Array = []

func _ready():
	for child in get_children():
		if child is Tile:
			tile_list.append(child)

	print("[board.gd] tile_list.size() =", tile_list.size())

func get_tile_by_coords(coords: Vector2i) -> Tile:
	for t in tile_list:
		if t.tile_coords == coords:
			return t
	return null
