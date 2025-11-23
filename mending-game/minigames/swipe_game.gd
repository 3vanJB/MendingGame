extends Node

@onready var swipable_object: SwipableObject = $SwipableObject

func _process(delta: float) -> void:
	if swipable_object != null:
		swipable_object.move(delta)

func _on_swipe_detector_swipe(vector: Variant, durationMillis: Variant) -> void:
	swipable_object.move_by_swipe(vector, durationMillis)


func _on_drop_zone_object_dropped(_objectType: int) -> void:
	print("You Win!")
