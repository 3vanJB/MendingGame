extends Control

var time_left : int = 5 # starting time
var m = time_left / 60
var s = time_left % 60
var score = 0

var lives : int = 5  # starting lives
@onready var tlabel = $HBoxContainer/TextureRect/HBoxContainer/timerLabel
@onready var scorelabel = $Score/scorelabel
@onready var plabel = $promptcontainer/Prompt
@onready var timer = $Timer
@onready var pausecontainer = $CanvasLayer/btnPauseContainer

signal gamelost

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass # Replace with function body.
	gamelost.connect(SIGNALBUS.ongamelost)
	pausecontainer.hide()
	$btnLostContainer.hide()
	
	
	#Engine.time_scale = 0.2 
	tlabel.text = "%2d" % [s]
	#get_node("Timer").start()
	
	update_lives_display()  # show initial lives
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func updatetime():
	tlabel.add_theme_color_override("font_color", Color.WHITE)
	s = time_left % 60
	tlabel.text = "%2d" % [s]

func _on_timer_timeout() -> void:
	#pass # Replace with function body.
	
	time_left -= 1
	
	m = time_left / 60
	s = time_left % 60
	tlabel.text = "%2d" % [s]

	# Change color in last 5 seconds
	if time_left <= 5:
		tlabel.add_theme_color_override("font_color", Color.RED)
	else:
		tlabel.add_theme_color_override("font_color", Color.WHITE)

	if time_left == 0:
		$Timer.stop()
		gamelost.emit()
		print("Timer finished!")

func incrementscore():
	score += 1
	scorelabel.text = str(score)

func resetscore():
	score = 0
	scorelabel.text = "0"
	AudioManager.music_setPitch( 1 + (score) )


func _on_btn_pause_pressed() -> void:
	#pass # Replace with function body.
	
	get_tree().paused = true
	pausecontainer.show()
	print ("Pause")


func _on_exit_pressed() -> void:
	#pass # Replace with function body.
	
	print ("Exit")
	get_tree().quit()


func _on_resume_pressed() -> void:
	#pass # Replace with function body.
	get_tree().paused = false
	pausecontainer.hide()
	print ("Resume")
	
	


func _on_restart_pressed() -> void:
	#pass # Replace with function body.
	
	get_tree().paused = false
	#get_tree().change_scene_to_file("res://game_play.tscn")
	get_tree().reload_current_scene()
	print ("Restart")
	


func _on_exit2_pressed() -> void:
	#pass # Replace with function body.
		
	print ("Exit after lost")
	get_tree().quit()


func _on_restart2_pressed() -> void:
	#pass # Replace with function body.
	
	$btnLostContainer.hide()
	
		# Decrease lives
	lives -= 1
	update_lives_display()

	# Reset the timer
	time_left = 10  # or your starting timer
	m = time_left / 60
	s = time_left % 60
	tlabel.text = "%02d:%02d" % [m, s]

	# Hide lost menu
	$btnLostContainer.hide()

	# Restart the timer
	$Timer.start()

	print("Restart after lost")

	if lives <= 0:
		get_tree().change_scene_to_file("res://main_menu.tscn")
		
		print("Game Over! Returning to main menu")
		return  # exit the function so timer doesn't restar


func update_lives_display() -> void:
	$HBoxContainer/lifeContainer/lifeNumber.text = str(lives)
