extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	HUD.globes.update_stacks(-1)
	pass # Replace with function body.
	#gotta add henrys entry animation


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.has_method("die"):
		for s in $sprites.get_children():
			s.frame = 1
		for x in range(3):
			var q = load("res://Items/singularGlobe.tscn").instance()
			q.position = global_position + Vector2(randf(),randf())
			get_tree().current_scene.call_deferred("add_child",q)
#		body.die()
		$Area2D.queue_free()
		yield(get_tree().create_timer(0.5, false), "timeout")
		$Tween.stop_all()
		$Tween.interpolate_property(self, "modulate:a", 1, 0, 0.5)
		$Tween.start()
		yield(get_tree().create_timer(0.5, false), "timeout")
		queue_free()
		#globe falling animation too right
		
