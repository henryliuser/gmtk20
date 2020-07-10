extends KinematicBody2D

#customers prob just wander aimlessley, attracted to the oil

# mask boolean? alive boolean?
var time = 0
var velocity = Vector2(0,0)
var angle = 0
var customer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var angle = (randi()%360 - 180)*(2*PI)/360
	velocity = Vector2(cos(angle),sin(angle)) * 50

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if time > 1 + randf() * 15:
		time = 0;
		angle = (randi()%360 - 180)*(2*PI)/360
		velocity = Vector2(cos(angle),sin(angle)) * 50
	move_and_slide(velocity)
	rotation = lerp(rotation, angle, .1)

func _on_Area2D_body_entered(body):
	if "rage" in body:
		#death
		queue_free()
