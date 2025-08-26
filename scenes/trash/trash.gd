extends Area2D
class_name Trash

@export var index: int
@export var value: float
@export var grab_rotation: int

func _ready() -> void:
	var random_rotation = randi_range(-360, 360)
	rotation = random_rotation

func grab():
	pass

func drop():
	if get_overlapping_areas():
		MoneyManager.get_money(value)
		queue_free()
