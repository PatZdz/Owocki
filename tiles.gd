extends Node2D

var teams = [
	"blue", "blue", "blue", "blue", "blue", "blue",
	"yellow", "yellow", "yellow", "yellow", "yellow", "yellow"
]

var pionek_textures = {
	"blue": ["res://1_blue.png", "res://2_blue.png", "res://3_blue.png"],
	"yellow": ["res://1_yellow.png", "res://2_yellow.png", "3_yellow.png"]
}

func _ready():
	teams.shuffle()  # Tasuj drużyny

	var tiles_node = $Group_Tiles  # Poprawiona ścieżka do Group Tiles
	if tiles_node == null:
		print("Node 'Group Tiles' not found!")
		return

	var empty_tiles = tiles_node.get_children()  # Pobierz dzieci w Group Tiles
	for i in range(teams.size()):
		var tile = empty_tiles[i]
		var team = teams[i]
		var pionek = create_pionek(team)
		tile.set_pionek(pionek)

func create_pionek(team) -> Node2D:
	var pionek = Sprite2D.new()
	pionek.texture = load("res://back.png")  # Rewers domyślnie
	pionek.set_meta("team", team)
	pionek.set_meta("awers", pionek_textures[team].randi())  # Losowy awers
	return pionek
