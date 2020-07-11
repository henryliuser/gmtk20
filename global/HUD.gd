extends Node2D
onready var cursor = $CanvasLayer/cursor
const base_CD = [3, 7, 10, 8, 9]
var employee_mult = 1
onready var vax = $buttons/vax
onready var oils = $buttons/oils
onready var tp = $buttons/tp

#func _input(event):
#	if event is InputEventMouseButton and event.pressed and cursor.selected != null:
		

#onready var vax_tw = $buttons/vaccine/Tween
#onready var vax_tp = $buttons/vaccine/TextureProgress
#func _on_vaccine_released():
#	if vax_tp.value == 0:
#		cursor.select("res://Items/Vaccine.tscn", 1.75, Color("7dc966"))
#		cooldown($buttons/vaccine/Tween, $buttons/vaccine/TextureProgress, base_CD[0] * employee_mult)
#
#onready var oils_tw = $buttons/oils/Tween
#onready var oils_tp = $buttons/oils/TextureProgress
#func _on_oils_released():
#	cursor.select("res://Items/Oils.tscn", 3, Color("#dd7f7f"))
#	cooldown($buttons/oils/Tween, $buttons/oils/TextureProgress, base_CD[0] * employee_mult)
#
#onready
#func _on_tp_released():
#	cursor.select("res://Items/ToiletPaper.tscn", 1.5)
#	cooldown($buttons/tp/Tween, $buttons/tp/TextureProgress, base_CD[0] * employee_mult)
#	var aoe2 = load("res://Items/AOE.tscn").instance()
#	aoe2.scale = Vector2(4,4)
#	get_tree().current_scene.add_child(aoe2)
#
#func _on_oilanim_mouse_entered():
#	$buttons/vaccine/vax.play("default")
#
#func _on_vax_animation_finished():
#	$buttons/vaccine/vax.stop()
	
func cooldown(tw, texture, cd):
	tw.stop_all()
	tw.interpolate_property(texture, "value", 100, 0, cd)
	tw.start()
