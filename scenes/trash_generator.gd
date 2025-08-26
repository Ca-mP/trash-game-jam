extends Node

@export var trash_amount: int
@export var trash_area: Area2D
@export var trash_collision_shape: CollisionShape2D

var current_index: int = 0

func _ready() -> void:
	generate_trash(trash_amount)

func generate_trash(trash_amt):
	var trash_types = ["bag", "banana", "beans", "bottle"]
	
	for i in trash_amt:
		var trash_position = Vector2(0, 0)
		
		var dumpster_size = trash_collision_shape.shape.size
		
		trash_position.x = randi_range(-(dumpster_size.x / 2), dumpster_size.x  / 2)
		trash_position.y = randi_range(-(dumpster_size.y  / 2), dumpster_size.y  / 2)
		
		var trash_type_index: int = randi_range(1, trash_types.size()) - 1
		var trash_filepath: String = "res://scenes/trash/trash_" + trash_types[trash_type_index] + ".tscn"
		
		var trash_piece = load(trash_filepath)
		var trash_scene = trash_piece.instantiate()
		trash_scene.index = current_index
		current_index += 1
		trash_scene.position = trash_position
		
		trash_area.add_child(trash_scene)
