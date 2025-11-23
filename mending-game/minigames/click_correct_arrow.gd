extends Node

const possible_inputs = ["up", "down", "left", "right"]
const button_distance = 125
var correct_input
var playing = true

func _on_ready() -> void:
	var button_blu = load("res://icon.svg")
	var button_red = load("res://icon_red.svg")
	
	correct_input = possible_inputs[randi() % possible_inputs.size()]
	for input in possible_inputs:
		if (input == correct_input):
			var button = _create_button(input, button_red)
			button.clicked.connect(_correct_button_clicked)
			add_child(button)
		else:
			var button = _create_button(input, button_blu)
			button.clicked.connect(_wrong_button_clicked)
			add_child(button)

func _create_rotated_sprite(inputEvent:StringName, texture:Texture2D) -> Sprite2D:
	var sprite = Sprite2D.new()
	sprite.texture = texture
	if (inputEvent == "right"):
		sprite.rotate(PI/2)
	elif (inputEvent == "down"):
		sprite.rotate(PI)
	elif (inputEvent == "left"):
		sprite.rotate(-PI/2)
	return sprite

func _create_button(inputEvent: StringName, texture: Texture2D) -> ArrowButton:
	var button = ArrowButton.new_arrow_button(inputEvent)
	var sprite = _create_rotated_sprite(inputEvent, texture)
	button.add_child(sprite)
	if (inputEvent == "up"):
		button.global_position.y -= button_distance
	elif (inputEvent == "right"):
		button.global_position.x += button_distance
	elif (inputEvent == "down"):
		button.global_position.y += button_distance
	elif (inputEvent == "left"):
		button.global_position.x -= button_distance
	return button

func _correct_button_clicked():
	if playing:
		print("You Win")
		playing = false

func _wrong_button_clicked():
	if playing:
		print("You Lose")
		playing = false
