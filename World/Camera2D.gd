extends Camera2D
var target = Vector2()
var spd = 10
func _physics_process(delta):
	global_position.x = lerp(global_position.x, target.x, 0.05)
	global_position.y = lerp(global_position.y, target.y, 0.05)
	if Input.is_action_pressed("cam_up"): target.y -= spd
	if Input.is_action_pressed("cam_down"): target.y += spd
	if Input.is_action_pressed("cam_left"): target.x -= spd
	if Input.is_action_pressed("cam_right"): target.x += spd
	target.x = clamp(target.x, -512, 512)
	target.y = clamp(target.y, -212, 300)
