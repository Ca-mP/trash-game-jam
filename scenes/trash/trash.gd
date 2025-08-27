extends Area2D
class_name Trash

@export var index: int
@export var value: float
@export var grab_rotation: int

var grabbed: bool = false
var drop_speed: int = 6
var move_from_wall: bool = true
var movement_direction: Vector2

var has_start_dropped: bool = false

func _ready() -> void:
	var random_rotation = randi_range(-360, 360)
	rotation = random_rotation

func _physics_process(delta: float) -> void:
	if not movement_direction == Vector2(0,0):
		position += movement_direction * drop_speed
		drop()
	
	var overlapping_areas = get_overlapping_areas()
	if overlapping_areas:
		for area in overlapping_areas:
			if (area.name == "LeftWall" or area.name == "RightWall" or area.name == "TopWall" or area.name == "BottomWall") and not grabbed:
				drop()

func grab():
	pass

func drop():
	var overlapping_areas = get_overlapping_areas()
	for area in overlapping_areas:
		if area.is_in_group("collection_bag"):
			MoneyManager.get_money(value)
			queue_free()
			
	for area in overlapping_areas:
		if area.name == "LeftWall":
			movement_direction.x = 1
			move_from_wall = true
		if area.name == "RightWall":
			movement_direction.x = -1
			move_from_wall = true
		if area.name == "TopWall":
			movement_direction.y = 1
			move_from_wall = true
		if area.name == "BottomWall":
			movement_direction.y = -1
			move_from_wall = true
	
	for area in overlapping_areas:
		if area.is_in_group("dumpster_walls"):
			return
	
	movement_direction = Vector2.ZERO
