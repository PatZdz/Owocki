extends Area2D
class_name Tile

@export var tile_index: int = 0
@export var tile_coords: Vector2i = Vector2i(0, 0)  # kolumna, wiersz
var piece_reference = null
var is_highlighted = false

func _ready():
	connect("input_event", Callable(self, "_on_tile_clicked"))

func is_occupied() -> bool:
	return piece_reference != null

func set_piece(piece):
	piece_reference = piece

func remove_piece():
	piece_reference = null

func highlight():
	is_highlighted = true
	# Ustaw z_index, by być nad pionkiem
	z_index = 10
	if $SpriteTile:
		$SpriteTile.z_index = 10
		$SpriteTile.modulate = Color(1, 0, 0, 0.5)  # czerwień półprzezroczysta

func unhighlight():
	is_highlighted = false
	z_index = 0
	if $SpriteTile:
		$SpriteTile.z_index = 0
		$SpriteTile.modulate = Color(1, 1, 1, 1)

func _on_tile_clicked(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if is_highlighted:
			# Nie musimy "consume", bo z_index=10
			var game = get_tree().get_root().get_node("Game")
			if game:
				game.on_tile_chosen(self)
		else:
			pass
