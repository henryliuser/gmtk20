extends AnimatedSprite

func _ready():
	$Tween.interpolate_property(self, 'modulate:a', 0, 1, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.interpolate_property(self, 'scale', scale, Vector2(2,2), 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.start()
	play()
	
func _on_AnimatedSprite_animation_finished():
	stop()
	yield(get_tree().create_timer(0.5, false), "timeout")
	queue_free()
