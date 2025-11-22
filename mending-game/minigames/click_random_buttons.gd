extends Node

@onready var area_2d: Area2D = $Area2D

func _on_ready() -> void:
	get_viewport().physics_object_picking_sort = true
	get_viewport().physics_object_picking_first_only = true
	generate_buttons(2)

func generate_buttons(number:=1) -> void:
	for n in number:
		var sprite = Sprite2D.new()
		sprite.texture = load("res://icon.svg")
	
		var shape = RectangleShape2D.new()
		shape.size = sprite.texture.get_size()
	
		var collision = CollisionShape2D.new()
		collision.shape = shape
	
		var button = NTimesButton.new_button(sprite, collision)
		button.set_global_position(Vector2(10.0 * n, 10.0 * n))
		add_child(button)
