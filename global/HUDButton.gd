extends TouchScreenButton
onready var hover = $hoveranim
onready var sprite = $sprite
onready var tex_progress = $TextureProgress
onready var tw = $Tween
export var base_cd = 3.0
export var scene = ""
export var scl = 2.0
export var color = Color()

func _ready():
	if sprite!= null: sprite.connect("animation_finished", self, "anim_done")

func cooldown():
	tw.stop_all()
	tw.interpolate_property(tex_progress, "value", 100, 0, base_cd * HUD.employee_mult)
	tw.start()

func _on_hoveranim_mouse_entered():
	print('yuh')
	if sprite.has_method("play"):
		sprite.playing = true
		print('yuh')

func anim_done():
	sprite.stop()

func _on_HUDButton_pressed():
	if tex_progress.value == 0: HUD.cursor.select(scene, scl, color)
