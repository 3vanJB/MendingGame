class_name NTimesArea
extends Area2D

signal area_removed

var mouse_inside_area: bool = false

static func new_area() -> NTimesArea:
	var this_scene: PackedScene = preload("res://game_elements/NTimesArea.tscn")
	var area: NTimesArea = this_scene.instantiate()
	return area

func _on_mouse_entered() -> void:
	mouse_inside_area = true
	print("Mouse Entered")
	
		
func _on_mouse_exited() -> void:
	if mouse_inside_area == true:
		area_removed.emit()
		queue_free()
		print("Mouse Exited")
	mouse_inside_area = false
