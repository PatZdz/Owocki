extends Sprite2D

func _ready():
	$Area2D.connect("input_event", self._on_input_event)

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		odsłoń_drużynę()

func odsłoń_drużynę():
	var awers = get_meta("awers")  # Pobierz przypisany awers
	if awers:
		texture = load(awers)  # Zmień teksturę na awers
