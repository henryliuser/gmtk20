extends Node2D
onready var tw = $Tween
onready var hbox = $hitbox
#onready var anim = $AnimatedSprite
var target = Vector2()
var time = 0.9

func _ready():
	HUD.vax.cooldown()
	target = global_position
	global_position = HUD.global_position+Vector2(530, 595)
	modulate.a = 0.3
	hbox.hide()
	$Tween.interpolate_property(self, "modulate:a", modulate.a, 1, 1)
	$Tween.interpolate_property($AnimatedSprite, "scale", Vector2(1.3,1.7), 
		$AnimatedSprite.scale, 1)
	tw.interpolate_property(self, "global_position", global_position, target, time,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tw.interpolate_property($AnimatedSprite, "rotation_degrees", 135, 495, time,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tw.start()
	yield(get_tree().create_timer(time, false), "timeout")
	hbox.show(); hbox.monitoring = true
	$AnimatedSprite.play()
	$AudioStreamPlayer2D.play()
	yield(get_tree().create_timer(0.3, false), "timeout")
	hbox.monitoring = false; hbox.hide()
	
func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.stop()
	tw.stop_all()
	tw.interpolate_property(self, "global_position", global_position, Vector2(1100, 300), time,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tw.interpolate_property($AnimatedSprite, "rotation_degrees", 135, 0, time,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tw.start()

func _on_hitbox_body_entered(body):
	if is_instance_valid(body) and "rage" in body:
		body.hit(2, global_position)
		body.vax()
