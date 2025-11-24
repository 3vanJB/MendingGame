extends Node2D

var remaining_buttons: int
@onready var spawn_area: SpawnArea = $SpawnArea
@onready var sprite = $Sword
var sparkle = preload("res://game_elements/sparkler.tscn")

signal gamewon

func _ready() -> void:
	gamewon.connect(SIGNALBUS.ongamewon)
	get_viewport().physics_object_picking_sort = true
	get_viewport().physics_object_picking_first_only = true
	
	var number_of_buttons = 5
	remaining_buttons = number_of_buttons
	generate_buttons(number_of_buttons)


func generate_buttons(number:=1) -> void:
	for n in number:
		var sprite = sparkle.instantiate()
		
	
		var shape = RectangleShape2D.new()
		shape.size = sprite.texture.get_size()
	
		var collision = CollisionShape2D.new()
		collision.shape = shape
	
		var button = NTimesButton.new_button()
		button.set_global_position(spawn_area.get_random_vector())
		button.button_removed.connect(_on_button_removed)
		add_child(button)

func _on_button_removed() -> void:
	AudioManager.audio_stream_02.play()
	remaining_buttons -= 1
	if remaining_buttons == 0:
		AudioManager.win_sound.play()
		sprite.play("fixed")
		gamewon.emit()


func _on_timer_timeout() -> void:
	sprite.play("broken")
