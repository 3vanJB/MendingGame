class_name SpawnArea
extends Area2D

func get_random_vector() -> Vector2:
	var collision = _get_collision()
	if collision == null:
		return Vector2.ZERO
	
	if is_instance_of(collision.shape, RectangleShape2D):
		return _get_random_rectangle_vector(collision)
	
	if is_instance_of(collision.shape, CircleShape2D):
		return _get_random_circle_vector(collision)
	
	return Vector2.ZERO

func _get_collision() -> CollisionShape2D:
	for child in self.get_children():
		if is_instance_of(child, CollisionShape2D):
			return child
	return null

func _get_random_rectangle_vector(collision: CollisionShape2D) -> Vector2:
	var positionX = position.x
	var positionY = position.y
	var offsetX = collision.shape.size.x / 2
	var offsetY = collision.shape.size.y / 2
	var x = randf_range((positionX - offsetX), (positionX + offsetX))
	var y = randf_range((positionY - offsetY), (positionY + offsetY))
	return Vector2(x,y)

func _get_random_circle_vector(collision: CollisionShape2D) -> Vector2:
	var distance = randf_range(0.0, collision.shape.radius)
	var angle = randf_range(0.0, TAU)
	var vector = Vector2.RIGHT
	
	return collision.position + (vector * distance).rotated(angle)
