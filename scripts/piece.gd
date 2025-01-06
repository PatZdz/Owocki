extends Area2D

@export var color: String = "red"  # lub "black"
@export var move_type: int = 0     # 0: przód, 1: ukos, 2: przód+ukos
var revealed: bool = false
var current_tile = null  # Referencja do Tile, na którym stoi

func _ready():
	# Ustaw grafikę rewersu na starcie
	$Sprite.texture = preload("res://images/back.png")
	# Podłącz sygnał, żeby wykryć klik
	connect("input_event", Callable(self, "_on_piece_clicked"))

func _on_piece_clicked(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		# Jeżeli pionek jest zakryty, odkrywamy go
		if not revealed:
			reveal_piece()

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
