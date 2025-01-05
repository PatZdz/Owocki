extends Sprite2D

var parent_tile = null

func _ready():
	$Area2D.connect("input_event", self._on_input_event)

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		move_to_tile()

func move_to_tile():
	var mouse_position = get_global_mouse_position()
	var tiles = get_tree().get_nodes_in_group("tiles")
	for tile in tiles:
		if tile.global_position.distance_to(mouse_position) < 100 and tile.is_empty():
			if parent_tile:
				parent_tile.set_pionek(null)  # Opróżnij poprzednie pole
			tile.set_pionek(self)
			parent_tile = tile
			break
