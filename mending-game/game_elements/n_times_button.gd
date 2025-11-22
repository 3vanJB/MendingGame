class_name NTimesButton
extends Area2D

var clicks: int
var mouse_inside_area: bool = false

static func new_button(
	sprite: Sprite2D,
	collision: CollisionShape2D,
	n_clicks: int = 1
	) -> NTimesButton:
	var this_scene: PackedScene = preload("res://game_elements/n_times_button.tscn")
	var button: NTimesButton = this_scene.instantiate()
	button.clicks = n_clicks
	button.add_child(sprite)
	button.add_child(collision)
	return button

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click") && mouse_inside_area:
		clicks -= 1
	if clicks < 1:
		queue_free()

func _on_mouse_shape_entered(_shape_idx: int) -> void:
	mouse_inside_area = true
	print(mouse_inside_area)


func _on_mouse_shape_exited(_shape_idx: int) -> void:
	mouse_inside_area = false
	print(mouse_inside_area)
