extends Node2D

var tile_list: Array = []
var piece_positions: Array = []  # Do zapisywania, który pionek jest na którym polu

func _ready():
	# Zbierz wszystkie Tile
	for tile in get_children():
		if tile is Area2D:
			tile_list.append(tile)
	for i in range(tile_list.size()):
		tile_list[i].tile_index = i
