extends Node

@onready var swipable_object: SwipableObject = $Swiper/SwipableObject
@onready var spawn_area: SpawnArea = $SpawnArea
@onready var drop_zone: DropZone = $DropZone

func _ready() -> void:
	var random_point = spawn_area.get_random_vector()
	spawn_area.queue_free()
	drop_zone.global_position = random_point

func _process(delta: float) -> void:
	if swipable_object != null:
		swipable_object.move(delta)

func _on_swipe_detector_swipe(vector: Variant, durationMillis: Variant) -> void:
	swipable_object.move_by_swipe(vector, durationMillis)


func _on_drop_zone_object_dropped(_objectType: int) -> void:
	print("You Win!")
