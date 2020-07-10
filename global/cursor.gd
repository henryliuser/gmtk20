extends Sprite
onready var tw = $Tween
onready var og_scale = scale
var selected = false
var rot_speed_deg = 50

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(event):
	if event is InputEventMouseButton and event.pressed: click()

func _physics_process(delta):
	global_position = get_global_mouse_position()
	if selected: 
		rotation_degrees += rot_speed_deg * delta
		if rotation_degrees > 360: rotation_degrees -= 360
		print(rotation_degrees)
	
func select(path, scl, mod = Color("ffffff")):
	var aoe = load("res://Items/AOE.tscn").instance()
	aoe.thing = path
	aoe.scale = Vector2(scl,scl)
	aoe.modulate = mod
	aoe.modulate.a = 0.5
	get_tree().current_scene.add_child(aoe)
	selected = true
	tw.stop_all()
	tw.interpolate_property(self,"scale", scale, Vector2(1.8,1.8),0.2,Tween.TRANS_CUBIC,Tween.EASE_OUT)
	tw.start()
	

func click():
	selected = false
	scale = Vector2(3.5,3.5)
	tw.stop_all()
	tw.interpolate_property(self, "scale", scale, og_scale, 0.2, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tw.interpolate_property(self, "rotation", rotation, 0, 0.2, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tw.start()
