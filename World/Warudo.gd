extends Node2D
onready var cam = $Camera2D
var curr = 0

func _ready():
	switch_cam(1)

func _input(event):
	if event.is_action_pressed("cam_1"): switch_cam(1)
	elif event.is_action_pressed("cam_2"): switch_cam(2)
	elif event.is_action_pressed("cam_3"): switch_cam(3)
	elif event.is_action_pressed("cam_4"): switch_cam(4)
	

func switch_cam(num):
	cam.target = $rooms.get_child(num-1).get_node("Center").global_position
