extends Area2D

func _ready():
	yield(get_tree().create_timer(0.1, false), "timeout")
	queue_free()

func _on_jab_body_entered(body):
	if "rage" in body:
		Global.hit(global_position)
		body.hit(3, global_position, 2, 30)
		queue_free()
