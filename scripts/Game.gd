extends Node2D
class_name Game

const PIECE_COUNT = 12

@onready var piece_scene = preload("res://scenes/Piece.tscn")
var pieces: Array = []

@onready var board: Board = $Board

var selected_piece: Piece = null
var highlighted_tiles: Array = []

func _ready():
	create_pieces()
	randomize_pieces_on_board()

func create_pieces():
	var piece_definitions = [
		# 6 niebieskich
		{"color": "blue",   "move_type": 0},  # 1 kropka
		{"color": "blue",   "move_type": 0},
		{"color": "blue",   "move_type": 1},  # 2 kropki
		{"color": "blue",   "move_type": 1},
		{"color": "blue",   "move_type": 2},  # 3 kropki
		{"color": "blue",   "move_type": 2},

		# 6 żółtych
		{"color": "yellow", "move_type": 0},
		{"color": "yellow", "move_type": 0},
		{"color": "yellow", "move_type": 1},
		{"color": "yellow", "move_type": 1},
		{"color": "yellow", "move_type": 2},
		{"color": "yellow", "move_type": 2},
	]

	for definition in piece_definitions:
		var p = piece_scene.instantiate() as Piece
		p.color = definition.color
		p.move_type = definition.move_type
		pieces.append(p)
		add_child(p)

func randomize_pieces_on_board():
	# Sprawdź, czy mamy co najmniej 12 tile
	if board.tile_list.size() < PIECE_COUNT:
		print("[game.gd] Błąd: board ma za mało kafelków! tile_list.size() =", board.tile_list.size())
		return

	pieces.shuffle()
	var tile_list = board.tile_list
	tile_list.shuffle()

	for i in range(PIECE_COUNT):
		var piece = pieces[i]
		var tile = tile_list[i]
		piece.position = tile.position
		piece.current_tile = tile
		tile.set_piece(piece)

func on_piece_clicked(piece: Piece):
	# Jeśli to ten sam pionek -> odznacz
	if selected_piece == piece:
		piece.set_selected(false)
		selected_piece = null
		_unhighlight_tiles()
		update_rotation_ui_visibility()
		return

	# Inny pionek
	if selected_piece:
		selected_piece.set_selected(false)
	selected_piece = piece
	piece.set_selected(true)

	# Podświetl
	_unhighlight_tiles()
	var possible_moves = piece.get_available_moves(board)
	print("[game.gd] possible_moves.size() =", possible_moves.size())
	for t in possible_moves:
		print("   highlight tile:", t.tile_coords)
		t.highlight()
		highlighted_tiles.append(t)

	update_rotation_ui_visibility()

func on_tile_chosen(tile: Tile):
	if selected_piece == null:
		return

	if not tile in highlighted_tiles:
		return

	if tile.is_occupied():
		var enemy = tile.piece_reference
		if enemy and enemy.color != selected_piece.color:
			# Zbij wroga
			enemy.queue_free()
			tile.remove_piece()

	# Przenieś pionek
	selected_piece.current_tile.remove_piece()
	tile.set_piece(selected_piece)
	selected_piece.current_tile = tile
	selected_piece.position = tile.position

	# Odznacz
	selected_piece.set_selected(false)
	selected_piece = null
	_unhighlight_tiles()
	update_rotation_ui_visibility()

func _unhighlight_tiles():
	for t in highlighted_tiles:
		t.unhighlight()
	highlighted_tiles.clear()

func update_rotation_ui_visibility():
	var panel = $UI/RotationPanel
	if selected_piece and selected_piece.revealed:
		panel.visible = true
	else:
		panel.visible = false

func deselect_piece():
	if selected_piece:
		selected_piece.set_selected(false)
		selected_piece = null
	_unhighlight_tiles()
	update_rotation_ui_visibility()

func _on_button_left_pressed():
	if selected_piece:
		selected_piece.rotate_left()

func _on_button_right_pressed():
	if selected_piece:
		selected_piece.rotate_right()
