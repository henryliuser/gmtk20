extends KinematicBody2D

#customers prob just wander aimlessley, attracted to the oil

# mask boolean? alive boolean?
var time = 0
var velocity = Vector2(0,0)
var angle = 0
var grunts = [load("res://Assets/SFX/hm1.wav"),
			  load("res://Assets/SFX/hm2.wav"),
			  load("res://Assets/SFX/hm3.wav")]
var customer = 0
var notChasing = true
var oilChasing = false
var text
var globeLines = ["who the fuck stocked these", "i knew i’d die at this store", "balls"]
var oilLines = ["owo whats this", "smells nice", "who put this here", "can you believe some people replace doctors with these"]

# Called when the node enters the scene tree for the first time.
func _ready():
	var angle = (randi()%360 - 180)*(2*PI)/360
	velocity = Vector2(cos(angle),sin(angle)) * 50
	while true:
		grunt()
		yield(get_tree().create_timer(randf()*5+2, false), "timeout")
		
func grunt():
	$AudioStreamPlayer2D.pitch_scale = 0.9 + randf()/5
	$AudioStreamPlayer2D.stream = grunts[randi()%3]
	$AudioStreamPlayer2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if notChasing and (time > 1 + randf() * 15 or is_on_wall()):
		time = 0;
		angle = (randi()%360 - 180)*(2*PI)/360
		velocity = Vector2(cos(angle),sin(angle)) * 50
	move_and_slide(velocity)
	rotation = lerp_angle(rotation, angle, .1)
	calc_sprite_rot()
	position_text()

func _on_Area2D_body_entered(body):
	if "rage" in body:
		#death
		die(true)
		body.enrage()

func oilAlert(x, y):
	oilChasing = true
	notChasing = false
	angle = atan2(y - position.y, x-position.x)
	velocity = Vector2(cos(angle),sin(angle)) * 50
	spawn_text(3, oilLines[randi()%4])
	
func unoilAlert():
	notChasing = true
	oilChasing = false

func die(bite = false):
	if bite: Global.bite(global_position)
	HUD.recount()
	queue_free()

var hitstun = 0
var hp = 5
func hit(dmg, source):
	hp -= dmg
	hitstun = 20
	velocity = source-global_position.normalized()*200
	if hp <= 0: die()
	else:
		if text!=null:
			text.elapsedTime = text.lifetime
			text.alive = false
		spawn_text(2, globeLines[randi()%3])

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
