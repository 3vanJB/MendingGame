class_name DropZone
extends Area2D

@warning_ignore("unused_signal")
signal objectDropped

@export var oneTimeDrop = false
var objects: Array[DraggableObject] = []

static func new_drop_zone(
	sprite: Sprite2D,
	collision: CollisionShape2D,
	isOneTimeDrop: bool = false
	) -> DropZone:
	var this_scene: PackedScene = preload("res://game_elements/drop_zone.tscn")
	var object: DropZone = this_scene.instantiate()
	object.add_child(sprite)
	object.add_child(collision)
	object.oneTimeDrop = isOneTimeDrop
	return object

func _process(_delta: float) -> void:
  pass
 
func on_object_dropped() -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	if is_instance_of(area, SwipableObject):
		_on_swipe_object_dropped(area)

func _on_swipe_object_dropped(object: SwipableObject) -> void:
	object.queue_free()
	objectDropped.emit(0)
	if oneTimeDrop:
		self.queue_free()
