extends Node2D

func _ready():
	HUD.hide()
	HUD.white(true)
	$Tween.interpolate_property(self, "modulate:a", 0, 1, 1)
	$Tween.start()
	yield(get_tree().create_timer(4, false), "timeout")
	get_tree().change_scene("res://global/Credits.tscn")
	
