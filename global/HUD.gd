extends Node2D
onready var cursor = $CanvasLayer/cursor

func _on_vaccine_released():
	cursor.select("res://Items/Vaccine.tscn", 1.75, Color("7dc966"))

func _on_oils_released():
	cursor.select("res://Items/Oils.tscn", 3, Color("#dd7f7f"))

func _on_tp_released():
	cursor.select("res://Items/ToiletPaper.tscn", 1.5)
	var aoe2 = load("res://Items/AOE.tscn").instance()
	aoe2.scale = Vector2(4,4)
	get_tree().current_scene.add_child(aoe2)

func _on_oilanim_mouse_entered():
	$buttons/vaccine/vax.play("default")
	
func _on_vax_animation_finished():
	$buttons/vaccine/vax.stop()
