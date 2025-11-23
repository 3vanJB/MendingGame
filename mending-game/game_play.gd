extends Control

var time_left : int = 10
var m = time_left / 60
var s = time_left % 60



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass # Replace with function body.
	
	#Engine.time_scale = 0.2 
	$timerLabel.text = "%02d:%02d" % [m, s]
	get_node("Timer").start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	time_left -= 1
	
	var m = time_left / 60
	var s = time_left % 60
	$timerLabel.text = "%02d:%02d" % [m, s]

	# Change color in last 5 seconds
	if time_left <= 5:
		$timerLabel.add_theme_color_override("font_color", Color.RED)
	else:
		$timerLabel.add_theme_color_override("font_color", Color.WHITE)


	#pass # Replace with function body.
