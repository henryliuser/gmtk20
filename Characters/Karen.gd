extends KinematicBody2D

# randomly wander. attracted to other characters, repelled by stuff

#speed/rage, infection status maybe
var time = 0
var velocity = Vector2(0,0)
var rage = 1.0 setget set_rage
var angle = 0
var notChasing = true
var oilChasing = false
var text
var hp = 100.0
onready var hpbar = get_node("../hpbar/poli/hpbar")
onready var audio = get_node("../AudioStreamPlayer2D")
onready var k = [load("res://Assets/SFX/kar1.wav"), 
				load("res://Assets/SFX/kar2.wav"),
				load("res://Assets/SFX/growl1.wav")]
onready var hurts = [load("res://Assets/SFX/hurt1.wav"),
					load("res://Assets/SFX/hurt2.wav"), 
					load("res://Assets/SFX/hurt3.wav"),
					load("res://Assets/SFX/hurt4.wav")]
var vax_instances = 0
var vax_center = Vector2()
var alertLines = ["its high noon", "are you the manager?", "if you dont come here you're oppressing me", "don't you know that masks are how the deep state controls you",]
var wallLines = ["touch me again and i’ll sue", "which incompetent let this be here", "this would never have happened in the good days", "i cant believe this happened to me"]
var oilLines = ["finally some good fucking food", "science told me these solve immunocompromisation", "did you know i sell these!"]
var tpLines = ["god, this is exactly what i needed", "mine", "i sense an essential item"]
var vaxLines = ["i already took my oils tho", "are you trying to give me 5g???", "this has definitely not been tested enough"]
var globeLines = ["the real earth wouldnt roll", "i cant believe they still make these in the wrong shape", "christopher columbus debunked these 50 years ago"]

# Called when the node enters the scene tree for the first time.
func _ready():
	angle = (randi()%360 - 180)*(2*PI)/360
	velocity = Vector2(cos(angle),sin(angle)) * 50 * rage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	time += delta
	var collider = $RayCast2D.get_collider()
	if hitstun > 0:
		$Sprite.global_rotation_degrees = lerp_angle($Sprite.global_rotation, -PI/2, 0.03)
		hitstun -= 1
		velocity = lerp(velocity, Vector2(), 0.2)
	elif vax_instances > 0:
		var ang = atan2(vax_center.y-global_position.y, vax_center.x-global_position.x)-PI/2
		var spd = Vector2(cos(ang), sin(ang))
		angle = ang
		velocity = 50*rage*spd
		if is_on_wall(): vax(true)
		
	elif notChasing and collider != null and ("customer" in collider or "employee" in collider):
		angle = atan2($RayCast2D.get_collider().global_position.y - global_position.y, 
			$RayCast2D.get_collider().global_position.x - global_position.x)
		velocity = Vector2(cos(angle),sin(angle)) * 50 * rage
		if collider.has_method("toggleForklift") and collider.forklift == true:
			angle -= PI
			velocity *= -1
		else:
			spawn_text(3, alertLines[randi()%4])
	elif notChasing and (time > 1 + randf() * 15 or is_on_wall()):
		if is_on_wall():
			spawn_text(1, wallLines[randi()%4])
		time = 0;
		angle = (randi()%360 - 180)*(2*PI)/360
		velocity = Vector2(cos(angle),sin(angle)) * 50 * rage
	
	move_and_slide(velocity)
	if hitstun > 0: pass
	else: 
		calc_sprite_rot()
		rotation = lerp_angle(rotation, angle, .1)
	position_text()
#	rotation = lerp_angle(rotation, (angle/4)+PI/2, .1)
#	rotation = 0

func tpAlert(x, y):
	if not oilChasing:
		notChasing = false
		angle = atan2(y - global_position.y, x-global_position.x)
		velocity = Vector2(cos(angle),sin(angle)) * 50 * rage
		spawn_text(2, tpLines[randi()%3])
	
func untpAlert():
	notChasing = true

func oilAlert(x, y):
	oilChasing = true
	notChasing = false
	angle = atan2(y - global_position.y, x-global_position.x)
	velocity = Vector2(cos(angle),sin(angle)) * 50 * rage
	spawn_text(3, oilLines[randi()%3])
	
func unoilAlert():
	notChasing = true
	oilChasing = false

func set_rage(ragen):
	if ragen < 1:
		rage = 1.0
	else:
		rage = ragen
	modulate.g = clamp(1/(rage/2.0), 0, 1)
	modulate.b = clamp(1/(rage/2.0), 0, 1)
	$Sprite.speed_scale = rage/4 + 0.75

		
func vax(chain = false):
	spawn_text(1, vaxLines[randi()%3])
	if !chain: 
		vax_instances += 1
		set_rage(rage+2)
	vax_center = global_position + Vector2((randi()%101-50)*2, (randi()%101-50)*2)
	yield(get_tree().create_timer(3, false), "timeout")
	if !chain: vax_instances -= 1

func calc_sprite_rot():
	while rotation_degrees >= 360: rotation_degrees -= 360
	while rotation_degrees <= -360: rotation_degrees += 360
	var rot = rotation_degrees
	if rotation_degrees < 0: rot = 360+rotation_degrees
	$Sprite.global_rotation_degrees = 0
#	$Sprite.global_rotation_degrees = lerp($Sprite.global_rotation_degrees, 0, 0.2)
	if rot >= 315 or rot < 45: $Sprite.play("right")
	if rot >= 45 and rot < 135: $Sprite.play("front")
	if rot >= 135 and rot < 225: $Sprite.play("left")
	if rot >= 225 and rot < 315: $Sprite.play("back")

func die():
	$Tween.stop_all()
	$Tween.interpolate_property(self, "modulate:a", 1, 0, 0.5)
	$Tween.start()
	yield(get_tree().create_timer(0.5, false), "timeout")
	HUD.recount()
	get_parent().queue_free()

var hitstun = 0
func hit(dmg, source, stun = 20, kb = 200):
	if text!=null:
		text.elapsedTime = text.lifetime
		text.alive = false
	spawn_text(2, globeLines[randi()%3])
	hp -= dmg
	modulate.a = 0.7
	yield(get_tree().create_timer(0.1, false), "timeout")
	modulate.a = 1
	set_rage(rage+dmg/15.0)
	hpbar.value = hp
	hitstun = stun
	velocity = (global_position-source).normalized()*kb
	if velocity.x < 0: rotation_degrees = 15
	else: rotation_degrees = -15
	audio.stream = hurts[randi()%4]
	audio.pitch_scale = 0.75 + randf()/2 if audio.stream != hurts[1] else 1.5
	audio.play()
	if hp <= 0: die()
	
func enrage():
	velocity = Vector2(0, 1)
	rotation_degrees = -90
	scale += Vector2(0.4, 0.4)
	set_rage(rage+1)
	$Sprite.play("front")
	hitstun = 40
	$Tween.stop_all()
#	$Tween.interpolate_property($Sprite, "rotation_degrees", 0, 359, 0.4, Tween.TRANS_CUBIC, Tween.EASE_OUT)
#	$Tween.interpolate_property($Sprite, "rotation_degrees", 25, -70, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT, 0.4)
	$Tween.interpolate_property(self, "scale", scale, scale-Vector2(0.3,0.3), 0.4)
#	$Tween.interpolate_property(self, "scale", scale+Vector2(0.1,0.1), scale+Vector2(0.2,0.2), 0.4, Tween.TRANS_CUBIC, Tween.EASE_OUT, 0.5)
	$Tween.start()
	yield(get_tree().create_timer(0.5,false), "timeout")
	if scale.x > 2: scale = Vector2(2,2)

func position_text():
	if text != null:
		text.rect_position = Vector2(30, -30) + global_position

func spawn_text(lifetime, line):
	audio.stream = k[randi()%3]
	audio.pitch_scale = 0.75 + randf()/2
	audio.play()
	if text == null or text.alive != true:
		text = load("res://Dialogue/TextBubble.tscn").instance()
		text.setLifetime(lifetime)
		text.text = line
		text.align = 1
		text.valign = 1
		get_tree().current_scene.add_child(text)

