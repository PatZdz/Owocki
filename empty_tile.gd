extends Node2D

var pionek = null  # Zmienna przechowująca pionek znajdujący się na polu

func is_empty() -> bool:
	return pionek == null  # Pole jest puste, jeśli nie ma pionka

func set_pionek(new_pionek):
	if pionek:
		remove_child(pionek)  # Usuń poprzedni pionek, jeśli istnieje

	pionek = new_pionek

	if pionek:
		add_child(pionek)  # Dodaj pionek jako dziecko pola
		pionek.position = Vector2(0, 0)  # Ustaw pionek na środku pola
