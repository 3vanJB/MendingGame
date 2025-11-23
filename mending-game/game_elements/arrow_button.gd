class_name ArrowButton
extends Node2D

signal clicked

var inputAction: StringName

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(inputAction):
		clicked.emit()

static func new_arrow_button(eventAction: StringName):
	var this_scene: PackedScene = load("res://game_elements/arrow_button.tscn")
	var button: ArrowButton = this_scene.instantiate()
	button.inputAction = eventAction
	return button
