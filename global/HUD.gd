extends CanvasLayer
onready var cursor = $cursor

func _on_vaccine_released():
	cursor.select("res://Items/Vaccine.tscn", 2)
