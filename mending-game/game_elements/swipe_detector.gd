extends Area2D

signal swipe(vector, durationMillis)

var sprite: Sprite2D
var collision: CollisionShape2D
var swiping = false
var swipeStartPosition: Vector2 = Vector2.ZERO
var swipeEndPosition: Vector2 = Vector2.ZERO
var swipeStartTime: int = 0
var swipeEndTime: int = 0
var mouse_inside_area: bool = false

func _process(_delta: float) -> void:
	if mouse_inside_area && Input.is_action_pressed("click") && not swiping:
			swipeStartTime = Time.get_ticks_msec()
			swipeStartPosition = get_viewport().get_mouse_position()
			swiping = true
	elif Input.is_action_just_released("click") and swiping:
			swipeEndPosition = get_viewport().get_mouse_position()
			swipeEndTime = Time.get_ticks_msec()
			swiping = false
			_emit_swipe()

func _emit_swipe():
	var swipeVector = swipeEndPosition - swipeStartPosition
	var swipeDurationMillis = swipeEndTime - swipeStartTime
	swipe.emit(swipeVector, swipeDurationMillis)

func _on_mouse_shape_entered(_shape_idx: int) -> void:
	mouse_inside_area = true

func _on_mouse_shape_exited(_shape_idx: int) -> void:
	mouse_inside_area = false
