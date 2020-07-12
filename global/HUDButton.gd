extends Area2D
onready var sprite = $sprite
onready var tex_progress = $TextureProgress
onready var tw = $Tween
onready var tooltip = $Tooltip_Delay
export var base_cd = 3.0
export var scene = ""
export var scl = 2.0
export var color = Color()
export var stacking = false
export var text = ""
var stacks = 0

var mouse_inside = false
var tooltip_delay = 0

func _input(event):
	if event is InputEventMouseButton and event.pressed and mouse_inside and event.button_index == BUTTON_LEFT:
		_on_HUDButton_pressed()

func _ready():
	if sprite!= null: sprite.connect("animation_finished", self, "anim_done")
	if stacking: tex_progress.tint_progress = Color("66ffffff")
	$Label.text = text

func cooldown():
	tw.stop_all()
	tw.interpolate_property(tex_progress, "value", 100, 0, base_cd * HUD.employee_mult)
	tw.start()

func _process(delta):
	if stacking and tex_progress.value == 0:
		tex_progress.value = 100
		cooldown()
		update_stacks(1)

func anim_done():
	sprite.stop()

func _on_HUDButton_pressed():
	if stacking and name == "tp": HUD._on_tp_pressed()
	if tex_progress.value == 0 or stacks > 0: 
		HUD.cursor.select(scene, scl, color)

onready var og_tint = tex_progress.tint_progress
func update_stacks(howmuch):
	stacks += howmuch
	get_parent().get_node("../" + name + "Stacks").text = str(stacks)
	if stacks == 0: tex_progress.tint_progress = og_tint
	else: tex_progress.tint_progress = Color("66ffffff")

func _on_HUDButton_mouse_entered():
	tooltip.start()
	mouse_inside = true
	if sprite.has_method("play"):
		sprite.play()

func _on_HUDButton_mouse_exited():
	mouse_inside = false
	tooltip.stop()
	$Label.hide()
	$TextBox2.hide()

func _on_Tooltip_Delay_timeout():
	$Label.show()
	$TextBox2.show()
