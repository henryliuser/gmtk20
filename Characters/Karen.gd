extends KinematicBody2D

# randomly wander. attracted to other characters, repelled by stuff

#speed/rage, infection status maybe
var time = 0
var velocity = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if time > randf() * 10:
		time = 0;
		velocity = Vector2(randf(),randf()) # might wanna change this to angle based, unsure
	move_and_slide(velocity)
