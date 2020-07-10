extends Sprite
var thing = ""

func _input(event):
	if event is InputEventMouseButton and event.pressed:
#		yield(get_tree().create_timer(0.1, false), "timeout")
		var item = load(thing).instance()
		item.position = global_position
		get_tree().current_scene.add_child(item)
		$Tween.interpolate_property(self, "scale", scale, scale+Vector2(0.2,0.2), 0.2,
			Tween.TRANS_CUBIC, Tween.EASE_OUT)
		$Tween.interpolate_property(self, "scale", scale, Vector2(), 0.5,
			Tween.TRANS_CUBIC, Tween.EASE_OUT, 0.2)
#		$Tween.interpolate_property(self, "rotation", 0, 2*PI-0.01, 0.5,
#			Tween.TRANS_CUBIC, Tween.EASE_OUT)
		$Tween.interpolate_property(self, "modulate:a", modulate.a, 0, 0.7,
			Tween.TRANS_CUBIC, Tween.EASE_OUT)
		$Tween.start()
		yield(get_tree().create_timer(0.55, false), "timeout")
		queue_free()

func _physics_process(delta):
	global_position = get_global_mouse_position()
