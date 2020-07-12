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

func recount():
	var emps = len(get_tree().current_scene.employees.get_children())
	var custs = len(get_tree().current_scene.customers.get_children())
	var kars = len(get_tree().current_scene.karens.get_children())
	$emp_count.text = "employees " + str(emps)
	$kar_count.text = "karens    " + str(kars)
	$cust_count.text = "customers " + str(custs)
	employee_mult = 5 if emps <= 0 else 5/emps
	if custs <= 0: Global.game_over()
	if kars <= 0: Global.win()
	
func white(r):
	cursor.white(r)

	
