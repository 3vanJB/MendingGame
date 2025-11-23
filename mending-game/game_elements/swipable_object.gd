class_name SwipableObject
extends Area2D

@export var SPEED_FACTOR = 2
@export var DECELERATION_FACTOR = 0.2

var direction = Vector2.ZERO
var speed = 0.0
var deceleration = 0.0

func move(delta: float) -> void:
	if speed > 0:
		self.global_position += direction * speed * delta
		speed -= deceleration * delta
		deceleration += deceleration * delta

func is_moving() -> bool:
	return speed > 0

func move_by_swipe(swipe_direction: Vector2, swipe_duration: int) -> void:
	direction = swipe_direction
	speed = _calculate_speed_from_swipe_duration(swipe_duration)
	deceleration = speed * DECELERATION_FACTOR


func _calculate_speed_from_swipe_duration(durationMillis: int) -> float:
	return 2 / sqrt(log(durationMillis))
