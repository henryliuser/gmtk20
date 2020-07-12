extends Area2D

func _on_forklift_body_entered(body):
	if body.has_method('toggleForklift'):
		body.toggleForklift()
