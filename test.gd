extends Area2D
var mouse_inside = false

func _input(event):
	if event is InputEventMouseButton and event.pressed and mouse_inside:
		print('click')

func _on_HUDButton_mouse_entered():
	mouse_inside = true
	print('in')

func _on_HUDButton_mouse_exited():
	mouse_inside = false
	print('out')
