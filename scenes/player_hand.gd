extends CharacterBody2D

@export var animator: AnimationPlayer
@export var grab_area: Area2D

var grabbed_trash

func _physics_process(delta: float) -> void:
	position = get_viewport().get_mouse_position()
	
	if Input.is_action_pressed("click"):
		animator.play("closed")
	else:
		animator.play("open")
	
	if grabbed_trash:
		grabbed_trash.global_position = global_position
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and grabbed_trash == null:
		var overlapping_trash: Array = grab_area.get_overlapping_areas()
		
		var highest_index = 0
		if overlapping_trash.size() == 1:
			grabbed_trash = overlapping_trash[0]
		else:
			for trash_piece in overlapping_trash:
				if trash_piece.index > highest_index:
					grabbed_trash = trash_piece
					trash_piece.grab()
					highest_index = trash_piece.index
	
	if Input.is_action_just_released("click"):
		if not grabbed_trash == null:
			grabbed_trash.drop()
			grabbed_trash = null
