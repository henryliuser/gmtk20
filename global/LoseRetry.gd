extends Node2D

func _ready():
	HUD.hide()
	HUD.white(true)
	$Tween.interpolate_property(self, "modulate:a", 0, 1, 2)
	$Tween.start()
	
func _on_Quit_pressed():
	get_tree().quit()

func _on_Start_pressed():
	get_tree().change_scene("res://Menu.tscn")
