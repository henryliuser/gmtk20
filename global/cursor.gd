extends Sprite
onready var tw = $Tween
onready var og_scale = scale
var selected = false
var rot_speed_deg = 50
var justSelected = false  # DUMB

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT: click()

func _physics_process(delta):
	if justSelected: justSelected = false
	global_position = get_global_mouse_position()
	if selected: 
		rotation_degrees += rot_speed_deg * delta
		if rotation_degrees > 360: rotation_degrees -= 360
	
func select(path, scl, mod = Color("ffffff")):
	var aoe = load("res://Items/AOE.tscn").instance()
	aoe.thing = path
	aoe.scale = Vector2(scl,scl)
	aoe.modulate = mod
	aoe.modulate.a = 0.5
	aoe.position = get_global_mouse_position()
	selected = true
	justSelected = true
	tw.stop_all()
	tw.interpolate_property(self,"scale", scale, Vector2(1.8,1.8),0.2,Tween.TRANS_CUBIC,Tween.EASE_OUT)
	tw.start()
	get_tree().current_scene.call_deferred("add_child", aoe)
	
var j = preload("res://Items/jab.tscn")
var jab_available = true
func click():
	if !justSelected: 
		selected = false
		scale = Vector2(3.5,3.5)
		tw.stop_all()
		tw.interpolate_property(self, "scale", scale, og_scale, 0.2, Tween.TRANS_CUBIC, Tween.EASE_OUT)
		tw.interpolate_property(self, "rotation", rotation, 0, 0.2, Tween.TRANS_CUBIC, Tween.EASE_OUT)
		tw.start()
	if HUD.visible and jab_available:
		var jab = j.instance()
		jab.position = global_position+get_tree().current_scene.cam.global_position-Vector2(512,300)
		get_tree().current_scene.add_child(jab)
		jab_available = false
		yield(get_tree().create_timer(1, false), "timeout")
		jab_available = true
		
func white(really):
	if really: $cursor2.show()
	else: $cursor2.hide()

