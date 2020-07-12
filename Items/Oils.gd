extends Node2D
var karens = {}
export var lifetime = 5
onready var sprite = $oilsTemp
onready var hitbox = $aoe/hitbox
onready var tw = $Tween
onready var aoe = $aoe
var started = false
var done = false
var time = 0.8

var karen_list = {} #badly named but i copy pasted it
var alerted_karens = []

func _ready():
	HUD.oils.cooldown()
	aoe.material = aoe.material.duplicate()
	aoe.material.set_shader_param("time_factor", randf()+randf()+randf()+randf())
	aoe.material.set_shader_param("amplitude", Vector2(3*randf()+1, 4*randf()+1))
	modulate.a = 0.3
	$Tween.interpolate_property(self, "modulate:a", modulate.a, 1, 1)
	var target = global_position + Vector2(-30,2)
	tw.interpolate_property(sprite, "global_position", HUD.global_position+Vector2(660,560), 
		target, time, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tw.interpolate_property(aoe, "scale", Vector2(), Vector2(3,3), time+0.5,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, time+0.1)
	tw.interpolate_property(sprite, "rotation_degrees", 0, 720, time,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tw.interpolate_property(sprite, "rotation_degrees", 0, 64, 0.4,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, time)
	tw.interpolate_property(sprite, "rotation_degrees", 64, 0, 0.4,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, time+0.6)
	tw.interpolate_property(sprite, "rotation_degrees", 0, 100, time,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, 2)
	tw.interpolate_property(sprite, "global_position", target, Vector2(-5000,2000), 
		time, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, 2)
	tw.start()
	yield(get_tree().create_timer(time+0.1, false), "timeout")
	$AudioStreamPlayer2D.play()
	aoe.visible = true
	hitbox.monitoring = true
	started = true

func _on_hitbox_body_entered(body):
	if "rage" in body:
		karens[body] = true
	if "oilChasing" in body:
		karen_list[body] = RayCast2D.new()
		karen_list[body].position = global_position
		karen_list[body].enabled = true
		get_tree().current_scene.add_child(karen_list[body])

func _on_hitbox_body_exited(body):
	if "rage" in body:
		karens.erase(body)
	if "oilChasing" in body:
		body.unoilAlert()
		karen_list[body].queue_free()
		karen_list.erase(body)

func _physics_process(delta):
	if started: lifetime -= delta
	if lifetime <= 0 and !done: end()
	for x in karens:
#		print(x.name + " " + str(x.rage))
		x.rage -= delta/1.5
	for karen in karen_list.keys():
		karen_list[karen].cast_to = 1.5 * (karen.position - position)
		var collider = karen_list[karen].get_collider()
		if collider != null and "oilChasing" in collider:
			karen.oilAlert(position.x, position.y)
			alerted_karens.append(karen)

func end():
	done = true
	$Tween.stop_all()
	$Tween.interpolate_property(aoe, "scale", aoe.scale, Vector2(), 0.5, 
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()
	yield(get_tree().create_timer(0.6, false), "timeout")
	queue_free()
	
