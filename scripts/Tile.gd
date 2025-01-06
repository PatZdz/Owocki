extends Area2D

@export var tile_index: int = 0
var piece_reference = null

func _ready():
	# Możesz podłączyć sygnał input_event, jeśli chcesz sprawdzać kliknięcia tutaj
	pass

func is_occupied() -> bool:
	return piece_reference != null

func set_piece(piece):
	piece_reference = piece

func remove_piece():
	piece_reference = null
