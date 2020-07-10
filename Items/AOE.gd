extends Sprite
var thing = ""

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		yield(get_tree().create_timer(0.2, false), "timeout")
		var item = load(thing).instance()
		item.position = global_position
		get_tree().current_scene.add_child(item)
		queue_free()

func _physics_process(delta):
	global_position = get_global_mouse_position()
