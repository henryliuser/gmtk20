extends Sprite

func _ready():
	yield(get_tree().create_timer(0.7, false), "timeout")
	queue_free()
