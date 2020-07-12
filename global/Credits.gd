extends Node2D
onready var tw = $Tween
onready var L1 = $credits/Label
onready var L2 = $credits/Label2
func _ready():
	HUD.white(true)
	HUD.hide()
	tw.interpolate_property($splash, "modulate", modulate, Color(), 3)
	tw.interpolate_property($credits, "modulate:a", 0, 1, Tween.TRANS_CUBIC,
		Tween.EASE_OUT, 2.5)
	tw.interpolate_property(L1, "rect_position", Vector2(-300,-300), 
		L1.rect_position, 4, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tw.interpolate_property(L2, "rect_position", Vector2(1424,900), 
		L2.rect_position, 4, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tw.interpolate_property(L1, "rect_position", L1.rect_position, 
		L1.rect_position+Vector2(0,1000), 4, Tween.TRANS_CUBIC, Tween.EASE_OUT, 6)
	tw.interpolate_property(L2, "rect_position", L2.rect_position, 
		L2.rect_position+Vector2(0,1000), 4, Tween.TRANS_CUBIC, Tween.EASE_OUT, 6)
	tw.interpolate_property($Label3, "modulate:a", 0, 1, 1, Tween.TRANS_CUBIC, Tween.EASE_OUT,8)
	tw.start()
