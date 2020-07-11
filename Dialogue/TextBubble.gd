extends Label


var lifetime = 2;
var elapsedTime = 0;
var alive = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	elapsedTime += delta
	if elapsedTime > lifetime:
		alive = false
		queue_free()

func setLifetime(time):
	lifetime = time
