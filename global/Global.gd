extends Node

func bite(pos):
	var b = load("res://Characters/bite.tscn").instance()
	b.global_position = pos
	get_tree().current_scene.add_child(b)
