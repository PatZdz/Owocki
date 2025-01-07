extends Area2D

enum Direction {UP, RIGHT, DOWN, LEFT}

@export var color: String = "blue"
@export var move_type: int = 0     # 0: przód, 1: ukos, 2: przód+ukos

var revealed: bool = false
var current_tile = null  # Referencja do Tile, na którym stoi
var direction: int = Direction.UP  # Domyślnie do góry

var is_selected: bool = false  # <-- NOWA ZMIENNA

func _ready():
	$Sprite.texture = preload("res://images/back.png")
	connect("input_event", Callable(self, "_on_piece_clicked"))

func _on_piece_clicked(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if not revealed:
			reveal_piece()
		else:
			# Jeśli pionek jest odkryty, powiadom Game o kliknięciu
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
	$Sprite.rotation_degrees = float(direction) * 90.0

func set_selected(value: bool):
	is_selected = value
	if is_selected:
		# 1) Lekko powiększ pionek (np. o 20%)
		scale = Vector2(1.2, 1.2)

		# 2) Dodaj obwódkę (kilka sposobów):
		#    a) Zmiana modulate, np. jasniejszy
		#       $Sprite.modulate = Color(1.1, 1.1, 1.1, 1) # minimalnie jaśniejszy
		#
		#    b) Drugi sprite w tle (np. $OutlineSprite) z "ramką"
		#       $OutlineSprite.visible = true
	else:
		# Cofnij skalę i ewentualnie odcienie
		scale = Vector2(1, 1)
		# $Sprite.modulate = Color(1, 1, 1, 1)
		# $OutlineSprite.visible = false
