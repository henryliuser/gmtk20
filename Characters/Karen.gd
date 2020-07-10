extends KinematicBody2D

# randomly wander. attracted to other characters, repelled by stuff

#speed/rage, infection status maybe
var time = 0
var velocity = Vector2(0,0)
var rage = 1
var angle = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	angle = (randi()%360 - 180)*(2*PI)/360
	velocity = Vector2(cos(angle),sin(angle)) * 50 * rage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	var collider = $RayCast2D.get_collider()
	if collider != null and ("customer" in collider or "employee" in collider):
		angle = atan2($RayCast2D.get_collider().position.y - position.y, $RayCast2D.get_collider().position.x - position.x)
		velocity = Vector2(cos(angle),sin(angle)) * 50 * rage
	elif time > 1 + randf() * 15:
		time = 0;
		angle = (randi()%360 - 180)*(2*PI)/360
		velocity = Vector2(cos(angle),sin(angle)) * 50 * rage
	move_and_slide(velocity)
	rotation = lerp(rotation, angle, .1)

