extends Node2D


var karen_list = {}
var alerted_karens = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	for karen in karen_list.keys():
		karen_list[karen].cast_to = 1.5 * (karen.position - position)
		var collider = karen_list[karen].get_collider()
		if collider != null and "rage" in collider:
			karen.tpAlert(position.x, position.y)
			alerted_karens.append(karen)


func _on_TP2_body_entered(body):
	if "rage" in body:
		#death
		for karen in alerted_karens:
			karen.untpAlert()
		for karen in karen_list:
			karen_list[karen].queue_free()
		queue_free()


func _on_Zone_body_entered(body):
	if "rage" in body:
		karen_list[body] = RayCast2D.new()
		karen_list[body].position = global_position
		karen_list[body].enabled = true
		get_tree().current_scene.add_child(karen_list[body])


func _on_Zone_body_exited(body):
	if "rage" in body and karen_list[body] != null:
		karen_list[body].queue_free()
		karen_list.erase(body)
