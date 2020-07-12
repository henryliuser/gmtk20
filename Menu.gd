extends Node2D

func _ready():
	HUD.visible = false

func _on_Start_pressed():
	get_tree().change_scene("res://World/Warudo.tscn")
	HUD.visible = true

func _on_Option_pressed():
	get_tree().change_scene("")

func _on_Quit_pressed():
	get_tree().quit()
