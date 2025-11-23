class_name DraggableObject
extends Area2D

var sprite: Sprite2D
var collision: CollisionShape2D
var type: int = 0
var dragging = false
var fired = false
var diff: Vector2 = Vector2.ZERO
var mouse_inside_area: bool = false
var areapos

static func new_object(
	#object_sprite: Sprite2D,
	#object_collision: CollisionShape2D,
	object_type:int = 0
	) -> DraggableObject:
	var this_scene: PackedScene = preload("res://game_elements/draggable_object.tscn")
	var object: DraggableObject = this_scene.instantiate()
	#object.sprite = object_sprite
	#object.add_child(object.sprite)
	#object.collision = object_collision
	#object.add_child(object.collision)
	object.type = object_type
	return object

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		diff = self.global_position - get_viewport().get_mouse_position()


func _process(delta: float) -> void:
	if mouse_inside_area && Input.is_action_pressed("click") && not dragging:
			dragging = true
	elif Input.is_action_just_released("click") and dragging == true:
			dragging = false
			print("asd")
			if get_overlapping_areas().size() > 0:
				self.input_pickable = false
				areapos = get_overlapping_areas()[0].position
				get_overlapping_areas()[0].objectDropped.emit()
				self.z_index = -10
				fired = true
				get_overlapping_areas()[0].queue_free()
				
			
	if dragging:
		self.position = get_viewport().get_mouse_position() + diff

func _physics_process(delta: float) -> void:
	if fired == true:
		self.position = self.position.move_toward(areapos, 5)

func _on_mouse_shape_entered(_shape_idx: int) -> void:
	mouse_inside_area = true

func _on_mouse_shape_exited(_shape_idx: int) -> void:
	mouse_inside_area = false
