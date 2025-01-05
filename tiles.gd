extends Node2D

var teams = [
	"blue", "blue", "blue", "blue", "blue", "blue",
	"yellow", "yellow", "yellow", "yellow", "yellow", "yellow"
]

func _ready():
	teams.shuffle()

	var empty_tiles = get_children()
	for i in range(teams.size()):
		var tile = empty_tiles[i]
		var pionek = create_pionek(teams[i])
		tile.set_pionek(pionek)

func create_pionek(team) -> Node2D:
	var pionek = Sprite2D.new()
	if team == "blue":
		pionek.texture = load("res://1_blue.png")
	elif team == "yellow":
		pionek.texture = load("res://1_yellow.png")
	pionek.set_meta("team", team)
	return pionek
