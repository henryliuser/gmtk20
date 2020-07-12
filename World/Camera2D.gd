extends Camera2D
var target = Vector2()

func _physics_process(delta):
	global_position.x = lerp(global_position.x, target.x, 0.2)
	global_position.y = lerp(global_position.y, target.y, 0.2)
