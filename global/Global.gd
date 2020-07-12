extends Node2D

func bite(pos):
	var b = load("res://Characters/bite.tscn").instance()
	b.global_position = pos
	get_tree().current_scene.add_child(b)

func game_over():
	get_tree().change_scene("res://global/LoseRetry.tscn")

var hm = preload("res://Items/hitmarker.tscn")
func hit(where):
	var hit = hm.instance()
	hit.position = where
	get_tree().current_scene.add_child(hit)
	$AudioStreamPlayer.play()
