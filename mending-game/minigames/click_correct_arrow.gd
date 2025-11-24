extends Node2D

const possible_inputs = ["up", "down", "left", "right"]
@onready var arrows = $Arrows
@onready var stick = $stick
const sprites = [preload("res://sprites/diagnosegame/fireico.png"), preload("res://sprites/diagnosegame/iceico.png"), 
preload("res://sprites/diagnosegame/paraico.png"), preload("res://sprites/diagnosegame/poisicon.png")]
var avaliablesprites = [sprites[0],sprites[1],sprites[2],sprites[3]]
const button_distance = 30
var correct_input
var correct_sprite
var playing = true

signal gamewon
signal gamelost

func _ready() -> void:
	gamewon.connect(SIGNALBUS.ongamewon)
	gamelost.connect(SIGNALBUS.ongamelost)
	
	var correctspriteindex = randi() % possible_inputs.size()
	correct_sprite = sprites[correctspriteindex]
	var correctinputindex = randi() % possible_inputs.size()
	correct_input = possible_inputs[correctinputindex]
	avaliablesprites.remove_at(correctspriteindex)
	for input in possible_inputs:
		if (input == correct_input):
			var button = _create_button(input, correct_sprite)
			button.clicked.connect(_correct_button_clicked)
			arrows.add_child(button)
		else:
			var randomsprite = randi() % avaliablesprites.size()
			var button = _create_button(input, avaliablesprites[randomsprite])
			button.clicked.connect(_wrong_button_clicked)
			avaliablesprites.remove_at(randomsprite)
			arrows.add_child(button)
		match correct_sprite:
			sprites[0]:
				stick.get_node("AnimationPlayer").play("onfire")
			sprites[1]:
				stick.get_node("AnimationPlayer").play("ice")
			sprites[2]:
				stick.get_node("AnimationPlayer").play("paral")
			sprites[3]:
				stick.get_node("AnimationPlayer").play("poison")
			_:
				pass
	

func _on_ready() -> void:
	#var button_blu = load("res://icon.svg")
	#var button_red = load("res://icon_red.svg")
	show()
	stick.show()
	

@warning_ignore("unused_parameter")
func _create_rotated_sprite(inputEvent:StringName, texture:Texture2D) -> Sprite2D:
	var sprite = Sprite2D.new()
	sprite.texture = texture
	#if (inputEvent == "right"):
		#sprite.rotate(PI/2)
	#elif (inputEvent == "down"):
		#sprite.rotate(PI)
	#elif (inputEvent == "left"):
		#sprite.rotate(-PI/2)
	return sprite

func _create_button(inputEvent: StringName, texture: Texture2D) -> ArrowButton:
	var sprite = _create_rotated_sprite(inputEvent, texture)
	var button = ArrowButton.new_arrow_button(inputEvent)
	button.add_child(sprite)
	if (inputEvent == "up"):
		AudioManager.audio_stream_02.play()
		button.global_position.y -= button_distance
	elif (inputEvent == "right"):
		AudioManager.audio_stream_02.play()
		button.global_position.x += button_distance
	elif (inputEvent == "down"):
		AudioManager.audio_stream_02.play()
		button.global_position.y += button_distance
	elif (inputEvent == "left"):
		AudioManager.audio_stream_02.play()
		button.global_position.x -= button_distance
	return button

func _correct_button_clicked():
	if playing:
		print("You Win")
		AudioManager.win_sound.play()
		get_tree().call_group("arrowbutton", "disable")
		stick.get_node("AnimationPlayer").play("win")
		await get_tree().create_timer(1).timeout
		hide()
		gamewon.emit()
		playing = false

func _wrong_button_clicked():
	if playing:
		AudioManager.fail_sound.play()
		print("You Lose")
		get_tree().call_group("arrowbutton", "disable")
		stick.get_node("AnimationPlayer").play("fail")
		await get_tree().create_timer(1).timeout
		hide()
		gamelost.emit()
		playing = false
