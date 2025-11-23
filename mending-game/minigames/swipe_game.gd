extends Node

const DECELERATION_FACTOR = 0.2

@onready var sprite_2d: Sprite2D = $Sprite2D
var direction = Vector2.ZERO
var speed = 0.0
var deceleration = 0.0
var durationRemaining = 0.0

func _process(delta: float) -> void:
	if speed > 0:
		sprite_2d.position += direction * speed * delta
		speed -= deceleration * delta
		deceleration += deceleration * delta

func _on_swipe_detector_swipe(vector: Variant, durationMillis: Variant) -> void:
	direction = vector
	speed = _calculate_speed_from_swipe_duration(durationMillis)
	deceleration = speed * DECELERATION_FACTOR

func _calculate_speed_from_swipe_duration(durationMillis: int) -> float:
	return 2 / sqrt(log(durationMillis))
