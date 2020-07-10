extends KinematicBody2D

#employees patrol? unsure how motion here should work

export var pointA = Vector2()
export var pointB = Vector2()
var target = Vector2()
var angle = 0
var speed = 0
var employee = 0


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
		speed = lerp(speed, 0, .1)
	else:
		speed = lerp(speed, 1, .1)
	vec = vec/vec.length()
	vec = vec * 50
	angle = atan2(vec.y, vec.x)
	rotation = lerp(rotation, angle, .1)
	move_and_slide(speed * vec)


func _on_Area2D_body_entered(body):
	if "rage" in body:
		#death
		queue_free()
