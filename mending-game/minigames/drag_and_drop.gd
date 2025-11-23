extends Node

var drop_zone_count: int
@onready var object_spawn_area: SpawnArea = $ObjectSpawnArea
@onready var drop_zone_spawn_area: SpawnArea = $DropZoneSpawnArea


func _on_ready() -> void:
	get_viewport().physics_object_picking_sort = true
	get_viewport().physics_object_picking_first_only = true
	
	var amount = 5
	drop_zone_count = amount
	generate_drop_zones(amount)
	generate_objects(amount)


func generate_objects(number:=1) -> void:
	for n in number:
		var sprite = Sprite2D.new()
		sprite.texture = load("res://icon.svg")
	
		var shape = RectangleShape2D.new()
		shape.size = sprite.texture.get_size()
	
		var collision = CollisionShape2D.new()
		collision.shape = shape
	
		var object = DraggableObject.new_object(sprite, collision)
		object.set_global_position(object_spawn_area.get_random_vector())
		add_child(object)
		
func generate_drop_zones(number:=1) -> void:
	for n in number:
		var sprite = Sprite2D.new()
		sprite.texture = load("res://icon_red.svg")
	
		var shape = RectangleShape2D.new()
		shape.size = sprite.texture.get_size()
	
		var collision = CollisionShape2D.new()
		collision.shape = shape
		
		#var scene = load("res://game_elements/drop_zone.tscn")
		#var object = scene.instantiate()
		var object = DropZone.new_drop_zone(sprite, collision, true)
		object.objectDropped.connect(_on_drop_zone_object_dropped)
		object.set_global_position(drop_zone_spawn_area.get_random_vector())
		add_child(object)
		
func _on_drop_zone_object_dropped(_objectType: int) -> void:
	drop_zone_count -= 1
	
	print(drop_zone_count)
	if drop_zone_count == 0:
		print("You Win!")
