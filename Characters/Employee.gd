extends KinematicBody2D

#employees patrol? unsure how motion here should work

export var pointA = Vector2()
export var pointB = Vector2()
var target = Vector2()
var angle = 0
var speed = 0
var employee = 0
var forklift = false


# Called when the node enters the scene tree for the first time.
func _ready():
	position = pointA

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var vec = position - pointA
	if vec.length() < 5:
		target = pointB
	vec = position - pointB
	if vec.length() < 5:
		 target = pointA
	vec = target - position;
	if vec.length() < 10:
		speed = lerp(speed, .1, .1)
	else:
		speed = lerp(speed, 1, .1)
	vec = vec/vec.length()
	vec = vec * 50
	angle = atan2(vec.y, vec.x)
	rotation = lerp_angle(rotation, angle, .1)
	move_and_slide(speed * vec)
	calc_sprite_rot()


func _on_Area2D_body_entered(body):
	if "rage" in body:
		if !forklift:
			die(true)
			body.enrage()
		else:
			body.die()

func die(bite = false):
	queue_free()
	if bite: Global.bite(global_position)

func calc_sprite_rot():
	while rotation_degrees >= 360: rotation_degrees -= 360
	while rotation_degrees <= -360: rotation_degrees += 360
	var rot = rotation_degrees
	if rotation_degrees < 0: rot = 360+rotation_degrees
	$Sprite.global_rotation_degrees = 0
	if rot >= 315 or rot < 45: $Sprite.play("right")
	if rot >= 45 and rot < 135: $Sprite.play("front")
	if rot >= 135 and rot < 225: $Sprite.play("left")
	if rot >= 225 and rot < 315: $Sprite.play("back")

func toggleForklift():
	forklift =  !forklift
