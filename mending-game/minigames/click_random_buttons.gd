extends Node2D

var remaining_buttons: int
@onready var spawn_area: SpawnArea = $SpawnArea
var sparkle = preload("res://game_elements/sparkler.tscn")

func _on_ready() -> void:
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
	remaining_buttons -= 1
	print(remaining_buttons)
	if remaining_buttons == 0:
		print("You Win!")
