extends Node2D
var karens = {}
export var lifetime = 5
var done = false

func _on_hitbox_body_entered(body):
	if "rage" in body:
		karens[body] = true

func _on_hitbox_body_exited(body):
	if "rage" in body:
		karens.erase(body)

func _physics_process(delta):
	lifetime -= delta
	if lifetime <= 0 and !done: end()
	for x in karens:
#		print(x.name + " " + str(x.rage))
		x.rage -= delta/2

func end():
	done = true
	$Tween.stop_all()
	$Tween.interpolate_property(self, "scale", scale, Vector2(), 0.5, 
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()
	yield(get_tree().create_timer(0.6, false), "timeout")
	queue_free()
	
