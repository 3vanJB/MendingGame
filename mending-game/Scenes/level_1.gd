extends Node2D


var games = {
	"diagnose":{"path":"res://minigames/click_correct_arrow.tscn", "text":"Cure!"},
	"wall":{"path":"res://minigames/drag_and_drop.tscn", "text": "Fix!"},
	"sword":{"path":"res://minigames/click_random_buttons.tscn", "text": "Shine!"}
	}
var nextgame = load(games["diagnose"]["path"])
var nexttext = games["diagnose"]["text"]
var curgame
@onready var HUD = $HUD
@onready var spawnmarker = $GameSpawn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SIGNALBUS.gamescene = self
	HUD.lives = 5
	startnextgame()

func startnextgame():
	HUD.timer.stop()
	HUD.time_left = 5
	HUD.updatetime()
	await get_tree().create_timer(1).timeout
	
	if curgame != null:
		curgame.hide()
		curgame.queue_free()
	await get_tree().create_timer(0.5).timeout
	HUD.plabel.text = nexttext
	HUD.plabel.show()
	await get_tree().create_timer(0.5).timeout
	HUD.plabel.hide()
	var game = nextgame.instantiate()
	game.position = spawnmarker.position
	HUD.timer.start()
	
	curgame = game
	add_child(game)
	var rgame = games[games.keys()[randi() % games.size()]]
	nexttext = rgame["text"]
	nextgame = load(rgame["path"])
	

func gamelost():
	HUD.lives -= 1
	HUD.update_lives_display()
	if HUD.lives > 0:
		startnextgame()
	else:
		gameover()

func gameover():
	
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
