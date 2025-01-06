extends Node2D

# Liczba pionków
const PIECE_COUNT = 12

# Odniesienie do sceny pionka
@onready var piece_scene = preload("res://scenes/Piece.tscn")

# Tablica wszystkich pionków
var pieces: Array = []

# Odniesienie do Board
@onready var board: Node2D = $Board

func _ready():
	# Przy starcie gry utwórz 12 pionków
	create_pieces()
	# Losowo rozmieść je na planszy
	randomize_pieces_on_board()

func create_pieces():
	# Chcemy 6 czerwonych i 6 czarnych
	# 2x (przód), 2x (ukos), 2x (przód+ukos) - i to samo dla czarnych
	# Zróbmy listę definicji
	var piece_definitions = [
		{"color": "blue",   "move_type": 0}, # przód
		{"color": "blue",   "move_type": 0},
		{"color": "blue",   "move_type": 1}, # ukos
		{"color": "blue",   "move_type": 1},
		{"color": "blue",   "move_type": 2}, # przód+ukos
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
		add_child(p)  # Dodajemy do sceny głównej (Game), można też do Board

func randomize_pieces_on_board():
	# Wylosuj kolejność pionków
	pieces.shuffle()

	# Odwołaj się do Board, wyciągnij tile_list (patrz Board.gd, tam mamy tile_list)
	var tile_list = board.tile_list
	# tile_list też można przetasować, by wylosować pola
	tile_list.shuffle()

	# Załóżmy, że mamy tyle samo tile co pionków = 12
	for i in range(PIECE_COUNT):
		var piece = pieces[i]
		var tile = tile_list[i]
		# Ustaw pionek na środku pola
		piece.position = tile.position
		# Zapisz w pionku, gdzie stoi
		piece.current_tile = tile
		# Zapisz w tile, że stoi tam pionek
		tile.set_piece(piece)
		# Pionki są na starcie zakryte - w skrypcie Piece.gd jest to domyślnie false (revealed = false)
		
		
