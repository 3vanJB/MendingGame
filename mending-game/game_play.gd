extends Control

var time_left : int = 5 # starting time
var m = time_left / 60
var s = time_left % 60
var score = 0

<<<<<<< HEAD
var lives : int = 5  # starting lives
@onready var tlabel = $HBoxContainer/TextureRect/HBoxContainer/timerLabel
@onready var scorelabel = $Score/scorelabel
=======
var lives : int = 3  # starting lives
var coins : int = 0

var current_level = null
var LEVEL_PATH = "res://minigames/"

const MINIGAME_LIST = [
	"click_random_buttons", # Level 1
	"drag_and_drop",        # Level 2
	"click_correct_arroa"   # Level 3
]

var current_minigame_index = 0
>>>>>>> Wanda

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass # Replace with function body.
	
	$btnPauseContainer.hide()
<<<<<<< HEAD
	$btnLostContainer.hide()
	
	
=======
	$btnNoLivesContainer.hide()
	$lblLostMsg.hide()
	$lblWinMsg.hide()
	$btnGoNextContainer.hide()
		
>>>>>>> Wanda
	#Engine.time_scale = 0.2 
	tlabel.text = "%2d" % [s]
	#get_node("Timer").start()
	
<<<<<<< HEAD
	update_lives_display()  # show initial lives
	
=======
	update_status_display()  # show initial lives
	
	load_new_level(MINIGAME_LIST[current_minigame_index])
>>>>>>> Wanda

	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


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
<<<<<<< HEAD
		$btnLostContainer.show()
=======
		# Decrease lives
		lives -= 1
		update_status_display()
		$lblLostMsg.show()
		$btnGoNextContainer.show()
>>>>>>> Wanda
		print("Timer finished!")

func incrementscore():
	score += 1
	scorelabel.text = str(score)

func resetscore():
	score = 0
	scorelabel.text = "0"


func _on_btn_pause_pressed() -> void:
	#pass # Replace with function body.
	
	get_tree().paused = true
	$btnPauseContainer.show()
	print ("Pause")


<<<<<<< HEAD
=======

func update_status_display() -> void:
	$lifeContainer/lifeNumber.text = str(lives)
	$coinContainer/coinNumber.text = str(coins)



>>>>>>> Wanda
func _on_exit_pressed() -> void:
	#pass # Replace with function body.
	
	print ("Exit")
	get_tree().quit()


func _on_resume_pressed() -> void:
	#pass # Replace with function body.
	get_tree().paused = false
	$btnPauseContainer.hide()
	print ("Resume")
	
	


func _on_restart_pressed() -> void:
	#pass # Replace with function body.
	
	get_tree().paused = false
	get_tree().change_scene_to_file("res://game_play.tscn")
	
	print ("Restart")
	


func _on_exit2_pressed() -> void:
	#pass # Replace with function body.
<<<<<<< HEAD
		
	print ("Exit after lost")
	get_tree().quit()
=======

	current_minigame_index += 1
	
	if current_minigame_index < MINIGAME_LIST.size():
		
		# --- Load Next Minigame ---
				
		# Reset and start the timer for the next level
		time_left = 10 
		m = time_left / 60
		s = time_left % 60
		$timerLabel.text = "%02d:%02d" % [m, s]
		$Timer.start()
		
		# Load the next level using the new index
		var next_level_name = MINIGAME_LIST[current_minigame_index]
		load_new_level(next_level_name)
		print("Starting next level: " + next_level_name)

	else:
		# --- Game Complete ---
		
		print("All minigames finished! Game Over.")
		
		get_tree().change_scene_to_file("res://main_menu.tscn") # Example transition


func load_new_level(level_name: String) -> void:
	if current_level:
		current_level.queue_free()
		current_level = null
		
	var new_level_scene = load(LEVEL_PATH + level_name + ".tscn")
	current_level = new_level_scene.instantiate()
	
	$nodeLevelRoot.add_child(current_level)
	
	if current_level.has_signal("minigame_finished"):
		current_level.minigame_finished.connect(Callable(self, "handle_minigame_win"))


func handle_minigame_win() -> void:
	# 1. Stop the main timer (optional, but usually desired on win)
	$Timer.stop() 
	coins += 1
	
	# 2. Show the win UI
	$lblWinMsg.show()
	$btnGoNextContainer.show() 
	
	print("Minigame Win - Showing next game option.")
>>>>>>> Wanda


func _on_restart2_pressed() -> void:
	#pass # Replace with function body.
	
	$btnLostContainer.hide()
	
		# Decrease lives
	lives -= 1
	update_status_display()

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
