extends KinematicBody2D

# randomly wander. attracted to other characters, repelled by stuff

#speed/rage, infection status maybe
var time = 0
var velocity = Vector2(0,0)
var rage = 1.0 setget set_rage
var angle = 0
var notChasing = true
var oilChasing = false

var vax_instances = 0
var vax_center = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	angle = (randi()%360 - 180)*(2*PI)/360
	velocity = Vector2(cos(angle),sin(angle)) * 50 * rage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	time += delta
	var collider = $RayCast2D.get_collider()
	if vax_instances > 0:
		var ang = atan2(vax_center.y-global_position.y, vax_center.x-global_position.x)-PI/2
		var spd = Vector2(cos(ang), sin(ang))
		velocity = 50*rage*spd
		
	elif notChasing and collider != null and ("customer" in collider or "employee" in collider):
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
		
func vax():
	rage += 2
	vax_instances += 1
	vax_center = global_position + Vector2((randi()%101-50)*2, (randi()%101-50)*2)
	yield(get_tree().create_timer(3, false), "timeout")
	vax_instances -= 1


