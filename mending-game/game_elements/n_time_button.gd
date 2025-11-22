class_name NTimeButton
extends Area2D

var clicks: int = 1
var mouse_inside_area: bool = false

func _process(_delta: float) -> void:
	if Input.is_action_pressed("click") && mouse_inside_area:
		clicks -= 1
	if clicks < 1:
		queue_free()

func _on_mouse_shape_entered(_shape_idx: int) -> void:
	mouse_inside_area = true


func _on_mouse_shape_exited(_shape_idx: int) -> void:
	mouse_inside_area = false
