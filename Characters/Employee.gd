extends KinematicBody2D

#employees patrol? unsure how motion here should work

export var pointA = Vector2()
export var pointB = Vector2()
var target = Vector2()
var angle = 0
var speed = 0
var employee = 0
var forklift = false
var text
var karenLines = ["ma’am i work at target", "ma’am you cant be here without a mask", "ma’am please stay 6 feet away"]
var globeLines = ["who the fuck stocked these", "i knew i’d die at this store", "balls"]
var forkLines = ["im finally assistant to the regional manager", "vroom vroom"]

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
	position_text()


func _on_Area2D_body_entered(body):
	if "rage" in body:
		if !forklift:
			die(true)
			body.enrage()
		else:
			body.die()

func die(bite = false):
	if bite: Global.bite(global_position)
	HUD.recount()
	queue_free()
	
	

func calc_sprite_rot():
	while rotation_degrees >= 360: rotation_degrees -= 360
	while rotation_degrees <= -360: rotation_degrees += 360
	var rot = rotation_degrees
	if rotation_degrees < 0: rot = 360+rotation_degrees
	$Sprite.global_rotation_degrees = 0
	if forklift:
		if rot >= 315 or rot < 45: $Sprite.play("rightFork")
		if rot >= 45 and rot < 135: $Sprite.play("frontFork")
		if rot >= 135 and rot < 225: $Sprite.play("leftFork")
		if rot >= 225 and rot < 315: $Sprite.play("backFork")
	else:
		if rot >= 315 or rot < 45: $Sprite.play("right")
		if rot >= 45 and rot < 135: $Sprite.play("front")
		if rot >= 135 and rot < 225: $Sprite.play("left")
		if rot >= 225 and rot < 315: $Sprite.play("back")

func toggleForklift():
	forklift =  !forklift
	if forklift:
		spawn_text(2, forkLines[randi()%2])

func position_text():
	if text != null:
		text.rect_position = Vector2(30, -30) + global_position

func spawn_text(lifetime, line):
	if text == null or text.alive != true:
		text = load("res://Dialogue/TextBubble.tscn").instance()
		text.setLifetime(lifetime)
		text.text = line
		text.align = 1
		text.valign = 1
		get_tree().current_scene.add_child(text)


func _on_Area2D2_body_entered(body):
	if "rage" in body:
		spawn_text(2, karenLines[randi()%3])
