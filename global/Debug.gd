extends Node
var frame_count = 0

func _input(event):
	if event.is_action_pressed("d_reset"): get_tree().reload_current_scene()
	if event.is_action_pressed("d_quit"): get_tree().quit()
	if event.is_action_pressed("d_pause"): get_tree().paused = !get_tree().paused
	if event.is_action_pressed("d_menu"): get_tree().change_scene("res://Menu.tscn")
	if event.is_action_pressed("d_frame_advance") and get_tree().paused: 
		get_tree().paused = false
		yield(get_tree().create_timer(1.0/60, false), "timeout")
		get_tree().paused = true

func _physics_process(delta):
	frame_count += 1
	
