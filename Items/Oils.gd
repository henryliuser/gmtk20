extends Node2D
var karens = {}
export var lifetime = 5
var done = false

var karen_list = {} #badly named but i copy pasted it
var alerted_karens = []

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
	lifetime -= delta
	if lifetime <= 0 and !done: end()
	for x in karens:
#		print(x.name + " " + str(x.rage))
		x.rage -= delta/2
	for karen in karen_list.keys():
		karen_list[karen].cast_to = 1.5 * (karen.position - position)
		var collider = karen_list[karen].get_collider()
		if collider != null and "oilChasing" in collider:
			karen.oilAlert(position.x, position.y)
			alerted_karens.append(karen)

func end():
	done = true
	$Tween.stop_all()
	$Tween.interpolate_property(self, "scale", scale, Vector2(), 0.5, 
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()
	yield(get_tree().create_timer(0.6, false), "timeout")
	queue_free()
	
