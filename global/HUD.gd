extends Node2D
onready var cursor = $CanvasLayer/cursor
const base_CD = [3, 7, 10, 8, 9]
var employee_mult = 1
onready var vax = $buttons/vax
onready var oils = $buttons/oils
onready var tp = $buttons/tp
onready var globes = $buttons/globes

func _process(delta):
	if get_tree().current_scene.name == "Warudo":
		HUD.global_position = get_tree().current_scene.cam.global_position - Vector2(512,300)

func _on_tp_pressed():
	if tp.stacks > 0:
		var aoe2 = load("res://Items/AOE.tscn").instance()
		aoe2.scale = Vector2(4,4)
		get_tree().current_scene.call_deferred("add_child", aoe2)
