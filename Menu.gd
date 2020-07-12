extends Node2D
onready var title = $titletext
onready var tw = $Tween
var offset = Vector2(0,5)
var dur = 1.2
func _ready():
	HUD.visible = false
	HUD.white(true)
	$Tween2.interpolate_property(self, "modulate:a", 0, 1, 1)
	$Tween2.start()
	tw.interpolate_property(title, "position", title.position-offset, title.position+offset, 
		dur, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tw.interpolate_property(title, "position", title.position+offset, title.position-offset,
		dur, Tween.TRANS_SINE, Tween.EASE_IN_OUT, dur)
	tw.start()

func _on_Start_pressed():
	get_tree().change_scene("res://World/Warudo.tscn")
	HUD.visible = true

func _on_Option_pressed():
	get_tree().change_scene("")

func _on_Quit_pressed():
	get_tree().quit()
