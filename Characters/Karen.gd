extends KinematicBody2D

# randomly wander. attracted to other characters, repelled by stuff

#speed/rage, infection status maybe
var time = 0
var velocity = Vector2(0,0)
var rage = 1.0 setget set_rage
var angle = 0
var notChasing = true
var oilChasing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	angle = (randi()%360 - 180)*(2*PI)/360
	velocity = Vector2(cos(angle),sin(angle)) * 50 * rage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	var collider = $RayCast2D.get_collider()
	if notChasing and collider != null and ("customer" in collider or "employee" in collider):
		angle = atan2($RayCast2D.get_collider().position.y - position.y, $RayCast2D.get_collider().position.x - position.x)
		velocity = Vector2(cos(angle),sin(angle)) * 50 * rage
	elif notChasing and time > 1 + randf() * 15:
		time = 0;
		angle = (randi()%360 - 180)*(2*PI)/360
		velocity = Vector2(cos(angle),sin(angle)) * 50 * rage
	move_and_slide(velocity)
	rotation = lerp_angle(rotation, angle, .1)

func tpAlert(x, y):
	if not oilChasing:
		notChasing = false
		angle = atan2(y - position.y, x-position.x)
		velocity = Vector2(cos(angle),sin(angle)) * 50 * rage
	
func untpAlert():
	notChasing = true

func oilAlert(x, y):
	oilChasing = true
	notChasing = false
	angle = atan2(y - position.y, x-position.x)
	velocity = Vector2(cos(angle),sin(angle)) * 50 * rage
	
func unoilAlert():
	notChasing = true
	oilChasing = false

func set_rage(ragen):
	if ragen < 1:
		rage = 1
	else:
		rage = ragen
