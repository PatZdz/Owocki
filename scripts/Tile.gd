extends Area2D

@export var tile_index: int = 0
var piece_reference = null

func _ready():
	# Możesz podłączyć sygnał input_event, jeśli chcesz klikać w puste pola
	# connect("input_event", Callable(self, "_on_tile_clicked"))
	pass

func is_occupied() -> bool:
	return piece_reference != null

func set_piece(piece):
	piece_reference = piece

func remove_piece():
	piece_reference = null

# Przykład, jeśli chcesz odznaczać pionek po kliknięciu w tile:
# func _on_tile_clicked(viewport, event, shape_idx):
#     if event is InputEventMouseButton and event.pressed:
#         # Odznacz pionek w Game
#         var game = get_tree().get_root().get_node("Game")
#         if game:
#             game.deselect_piece()
