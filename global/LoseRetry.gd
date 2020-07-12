extends Node2D

func _ready():
	HUD.hide()
	HUD.white(true)
	$Tween.interpolate_property(self, "modulate:a", 0, 1, 2)
	$Tween.interpolate_property($defeattext, "position", $defeattext.position, 
		Vector2(1500,270), 2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, 3)
	$Tween.interpolate_property($Label, "rect_position", Vector2(-1000, 100), 
		$Label.rect_position, 2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, 3)
	$Tween.start()
	yield(get_tree().create_timer(3, false), "timeout")
	$Label.show()
	
func _on_Quit_pressed():
	get_tree().quit()

func _on_Start_pressed():
	get_tree().change_scene("res://Menu.tscn")
