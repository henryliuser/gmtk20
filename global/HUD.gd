extends CanvasLayer
onready var cursor = $cursor

func _on_vaccine_released():
	cursor.select("res://Items/Vaccine.tscn", 2, Color("7dc966"))

func _on_oils_released():
	cursor.select("res://Items/Oils.tscn", 3.5, Color("#dd7f7f"))

func _on_tp_released():
	cursor.select("res://Items/ToiletPaper.tscn", 1.5)

