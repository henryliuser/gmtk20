extends TouchScreenButton
onready var hover = $hoveranim
onready var sprite = $sprite
onready var tex_progress = $TextureProgress
onready var tw = $Tween
export var base_cd = 3.0
export var scene = ""
export var scl = 2.0
export var color = Color()
export var stacking = false
var stacks = 0

func _ready():
	if sprite!= null: sprite.connect("animation_finished", self, "anim_done")
	if stacking: tex_progress.tint_progress = Color("66ffffff")

func cooldown():
	tw.stop_all()
	tw.interpolate_property(tex_progress, "value", 100, 0, base_cd * HUD.employee_mult)
	tw.start()

func _process(delta):
	if stacking and tex_progress.value == 0:
		tex_progress.value = 100
		cooldown()
		update_stacks(1)

func _on_hoveranim_mouse_entered():
	print('yuh')
	if sprite.has_method("play"):
		sprite.playing = true
		print('yuh')

func anim_done():
	sprite.stop()

func _on_HUDButton_pressed():
	if tex_progress.value == 0 or stacks > 0: 
		HUD.cursor.select(scene, scl, color)
		
onready var og_tint = tex_progress.tint_progress
func update_stacks(howmuch):
	stacks += howmuch
	get_parent().get_node("../Label").text = str(stacks)
	if stacks == 0: tex_progress.tint_progress = og_tint
	else: tex_progress.tint_progress = Color("66ffffff")
