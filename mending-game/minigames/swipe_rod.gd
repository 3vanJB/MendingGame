extends Node2D

var remaining_areas: int
@onready var spawn_area: SpawnArea = $SpawnArea2D
var sparkle = preload("res://game_elements/sparkler.tscn")


signal gamewon


func generate_areas(number:=1) -> void:
	for n in number:
		var sprite = sparkle.instantiate()
		
	
		var shape = RectangleShape2D.new()
		shape.size = sprite.texture.get_size()
	
		var collision = CollisionShape2D.new()
		collision.shape = shape
	
		var area = NTimesArea.new_area()
		area.set_global_position(spawn_area.get_random_vector())
		area.area_removed.connect(_on_areas_removed)
		add_child(area)
		
func _on_areas_removed() -> void:
	AudioManager.audio_stream_02.play()
	remaining_areas -= 1
	if remaining_areas == 0:
		$Tape.visible = true
		AudioManager.win_sound.play()
		gamewon.emit()


func _on_ready() -> void:
	$Tape.visible = false
	gamewon.connect(SIGNALBUS.ongamewon)
	get_viewport().physics_object_picking_sort = true
	get_viewport().physics_object_picking_first_only = true
	
	var number_of_areas = randi_range(4,7)
	remaining_areas = number_of_areas
	generate_areas(number_of_areas)
