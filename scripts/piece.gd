extends Area2D
class_name Piece

enum Direction {UP, RIGHT, DOWN, LEFT}

@export var color: String = "blue"
@export var move_type: int = 0  # 0=1kropka,1=2kropki,2=3kropki

var revealed: bool = false
var current_tile = null  # Tile, na którym stoi
var direction: int = Direction.UP
var is_selected: bool = false

func _ready():
	$Sprite.texture = preload("res://images/back.png")
	connect("input_event", Callable(self, "_on_piece_clicked"))

func _on_piece_clicked(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if not revealed:
			reveal_piece()
		else:
			var game = get_tree().get_root().get_node("Game")
			if game:
				game.on_piece_clicked(self)

func reveal_piece():
	revealed = true
	match color:
		"blue":
			if move_type == 0:
				$Sprite.texture = preload("res://images/1_blue.png")
			elif move_type == 1:
				$Sprite.texture = preload("res://images/2_blue.png")
			else:
				$Sprite.texture = preload("res://images/3_blue.png")
		"yellow":
			if move_type == 0:
				$Sprite.texture = preload("res://images/1_yellow.png")
			elif move_type == 1:
				$Sprite.texture = preload("res://images/2_yellow.png")
			else:
				$Sprite.texture = preload("res://images/3_yellow.png")

func rotate_left():
	direction = (direction - 1) % 4
	update_visual_rotation()

func rotate_right():
	direction = (direction + 1) % 4
	update_visual_rotation()

func update_visual_rotation():
	# 0=UP->0°,1=RIGHT->90°,2=DOWN->180°,3=LEFT->270°
	$Sprite.rotation_degrees = float(direction) * 90.0

func set_selected(value: bool):
	is_selected = value
	if is_selected:
		scale = Vector2(1.2, 1.2)
	else:
		scale = Vector2(1, 1)

func get_available_moves(board) -> Array:
	var moves = []
	if current_tile == null:
		return moves

	var coords = current_tile.tile_coords
	var forward_vec = Vector2i(0, -1)
	if direction == Direction.RIGHT:
		forward_vec = Vector2i(1, 0)
	elif direction == Direction.DOWN:
		forward_vec = Vector2i(0, 1)
	elif direction == Direction.LEFT:
		forward_vec = Vector2i(-1, 0)

	var candidates = []

	# move_type=0 -> 1kropka -> TYLKO przód
	if move_type == 0:
		candidates.append(coords + forward_vec)
	# move_type=1 -> 2kropki -> TYLKO ukos
	elif move_type == 1:
		# "Ukos" w siatce 2D, = forward_vec + left_vec / right_vec
		var left_vec = Vector2i(-forward_vec.y, forward_vec.x)
		var right_vec = Vector2i(forward_vec.y, -forward_vec.x)
		candidates.append(coords + forward_vec + left_vec)
		candidates.append(coords + forward_vec + right_vec)
	else:
		# move_type=2 -> 3kropki -> przód + ukos
		candidates.append(coords + forward_vec)
		var left_vec = Vector2i(-forward_vec.y, forward_vec.x)
		var right_vec = Vector2i(forward_vec.y, -forward_vec.x)
		candidates.append(coords + forward_vec + left_vec)
		candidates.append(coords + forward_vec + right_vec)

	for c in candidates:
		var tile_candidate = board.get_tile_by_coords(c)
		if tile_candidate != null:
			if not tile_candidate.is_occupied():
				moves.append(tile_candidate)
			else:
				var occupant = tile_candidate.piece_reference
				if occupant and occupant.color != color:
					moves.append(tile_candidate)
	return moves
