extends Node2D

func _ready():
	global_rotation_degrees = 0

func _physics_process(delta):
	global_position = get_node("../Body").global_position+Vector2(0, -60)
#	global_position = lerp(global_position, 
#		get_node("../Karen").global_position + Vector2(0, -60), 0.3)

func _on_hpbar_value_changed(value):
	$Tween.interpolate_property($poli, "value", $poli.value+5, value, 0.5, 
		Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.start()
