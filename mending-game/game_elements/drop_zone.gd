class_name DropZone
extends Area2D

signal objectDropped(objectType: int)

var oneTimeDrop = false
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
	for object in objects:
		if not object.dragging:
			_on_object_dropped(object)

func _on_area_entered(area: Area2D) -> void:
	if is_instance_of(area, DraggableObject):
		objects.push_back(area)

func _on_area_exited(area: Area2D) -> void:
	if is_instance_of(area, DraggableObject):
		objects.erase(area)

func _on_object_dropped(object: DraggableObject) -> void:
	objects.erase(object)
	objectDropped.emit(object.type)
	object.queue_free()
	if oneTimeDrop:
		self.queue_free()
