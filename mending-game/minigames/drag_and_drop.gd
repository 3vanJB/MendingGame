extends Node


func _on_ready() -> void:
	get_viewport().physics_object_picking_sort = true
	get_viewport().physics_object_picking_first_only = true
	var sprite = Sprite2D.new()
	sprite.texture = load("res://icon.svg")
	
	var shape = RectangleShape2D.new()
	shape.size = sprite.texture.get_size()
	
	var collision = CollisionShape2D.new()
	collision.shape = shape
	
	var dragObj = DraggableObject.new_object(sprite, collision)
	add_child(dragObj)
