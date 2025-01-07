extends Node2D

const PIECE_COUNT = 12
@onready var piece_scene = preload("res://scenes/Piece.tscn")
var pieces: Array = []

@onready var board: Node2D = $Board

var selected_piece = null  # Referencja do aktualnie zaznaczonego pionka

func _ready():
	create_pieces()
	randomize_pieces_on_board()

func create_pieces():
	var piece_definitions = [
		{"color": "blue",   "move_type": 0},
		{"color": "blue",   "move_type": 0},
		{"color": "blue",   "move_type": 1},
		{"color": "blue",   "move_type": 1},
		{"color": "blue",   "move_type": 2},
		{"color": "blue",   "move_type": 2},

		{"color": "yellow", "move_type": 0},
		{"color": "yellow", "move_type": 0},
		{"color": "yellow", "move_type": 1},
		{"color": "yellow", "move_type": 1},
		{"color": "yellow", "move_type": 2},
		{"color": "yellow", "move_type": 2},
	]

	for definition in piece_definitions:
		var p = piece_scene.instantiate()
		p.color = definition.color
		p.move_type = definition.move_type
		pieces.append(p)
		add_child(p)

func randomize_pieces_on_board():
	pieces.shuffle()
	var tile_list = board.tile_list
	tile_list.shuffle()

	for i in range(PIECE_COUNT):
		var piece = pieces[i]
		var tile = tile_list[i]
		piece.position = tile.position
		piece.current_tile = tile
		tile.set_piece(piece)

func on_piece_clicked(piece):
	# 1. Czy user klika ten sam pionek, co był wybrany?
	if selected_piece == piece:
		# -> Odznaczamy go
		piece.set_selected(false)
		selected_piece = null
		update_rotation_ui_visibility()
		return

	# 2. Inny pionek
	# a) Jeśli był wybrany jakiś inny - odznacz go
	if selected_piece != null:
		selected_piece.set_selected(false)

	# b) Zaznacz nowy
	selected_piece = piece
	piece.set_selected(true)

	# c) Ewentualnie pokaż UI do obrotu
	update_rotation_ui_visibility()

func update_rotation_ui_visibility():
	# Załóżmy, że masz panel w $UI/RotationPanel
	var panel = $UI/RotationPanel
	if selected_piece and selected_piece.revealed:
		panel.visible = true
	else:
		panel.visible = false

func deselect_piece():
	if selected_piece:
		selected_piece.set_selected(false)
		selected_piece = null
	update_rotation_ui_visibility()

func _on_button_left_pressed():
	if selected_piece:
		selected_piece.rotate_left()

func _on_button_right_pressed():
	if selected_piece:
		selected_piece.rotate_right()
