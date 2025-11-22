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
	var x = randf_range(collision.position.x, (collision.position.x + collision.shape.size.x))
	var y = randf_range(collision.position.y, (collision.position.y + collision.shape.size.y))
	return Vector2(x,y)

func _get_random_circle_vector(collision: CollisionShape2D) -> Vector2:
	var distance = randf_range(0.0, collision.shape.radius)
	var angle = randf_range(0.0, TAU)
	var vector = Vector2.RIGHT
	
	return collision.position + (vector * distance).rotated(angle)
