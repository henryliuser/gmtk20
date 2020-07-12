extends RigidBody2D

func _ready():
	linear_velocity = Vector2(randf()*300-150, randf()*300-150)
	angular_velocity = randf()*30

func _physics_process(delta):
	if len(get_colliding_bodies()) > 1:
			linear_velocity *= -1.2
			angular_velocity *= -1.2

func _on_Area2D_body_entered(body):
	if body.has_method("hit"):
		body.hit(5, global_position)

func _on_Timer_timeout():
	$Tween.interpolate_property(self, "modulate:a", 1, 0, 0.5)
	$Tween.start()
	yield(get_tree().create_timer(0.5, false), "timeout")
	queue_free()
