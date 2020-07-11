extends Node2D

var karen_list = {}
var alerted_karens = []

# Called when the node enters the scene tree for the first time.
func _ready():
	HUD.tp.cooldown()
	var target = global_position
	global_position = Vector2(750, 555)
	modulate.a = 0.3
	$Zone.hide(); $TP2.hide()
	$Tween.interpolate_property(self, "modulate:a", modulate.a, 1, 1)
	$Tween.interpolate_property(self, "rotation_degrees", rotation_degrees, 1079, 1,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(self, "global_position", global_position, target, 1,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()
	yield(get_tree().create_timer(1,false),"timeout")
	$Zone.show(); $TP2.show()
	$Zone.monitoring = true
	$TP2.monitoring = true

func _process(delta):
	for karen in karen_list.keys():
		karen_list[karen].cast_to = 1.5 * (karen.position - position)
		var collider = karen_list[karen].get_collider()
		if collider != null and "rage" in collider:
			karen.tpAlert(position.x, position.y)
			alerted_karens.append(karen)

func _on_TP2_body_entered(body):
	if "rage" in body:
		queue_free()
#	if "rage" in body:
#		#death
#		for karen in alerted_karens:
#			karen.untpAlert()
#		for karen in karen_list:
#			karen_list[karen].queue_free()
#		queue_free()


func _on_Zone_body_entered(body):
	if "rage" in body:
		var ray = RayCast2D.new()
		ray.position = Vector2()
		ray.enabled = true
		ray.exclude_parent = true
		karen_list[body] = ray
		add_child(ray)


func _on_Zone_body_exited(body):
	if "rage" in body and karen_list[body] != null:
		karen_list[body].queue_free()
		karen_list.erase(body)
