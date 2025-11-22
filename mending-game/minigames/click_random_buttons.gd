extends Node


func _on_ready() -> void:
	var sprite = Sprite2D.new()
	sprite.texture = load("res://icon.svg")
	
	var shape = RectangleShape2D.new()
	shape.size = sprite.texture.get_size()
	
	var collision = CollisionShape2D.new()
	collision.shape = shape
	
	var button = NTimesButton.new_button(sprite, collision)
	button.set_global_position(Vector2(20.0, 20.0))
	add_child(button)
