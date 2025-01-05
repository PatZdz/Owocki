extends Node2D

var pionek = null  # Zmienna przechowująca pionek znajdujący się na polu

func is_empty() -> bool:
	return pionek == null  # Pole jest puste, jeśli nie ma pionka

func set_pionek(new_pionek):
	pionek = new_pionek
	if pionek:
		pionek.position = position  # Ustaw pionek na środku pola
