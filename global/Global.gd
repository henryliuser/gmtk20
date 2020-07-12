extends Node

func bite(pos):
	var b = load("res://Characters/bite.tscn").instance()
	b.global_position = pos
	get_tree().current_scene.add_child(b)

func game_over():
	get_tree().change_scene("res://global/LoseRetry.tscn")
