extends Node2D


var games = {
	"diagnose":{"path":"res://minigames/click_correct_arrow.tscn", "text":"Cure!"},
	}
var nextgame = load(games["diagnose"]["path"])
var curgame
@onready var HUD = $HUD
@onready var spawnmarker = $GameSpawn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SIGNALBUS.gamescene = self
	HUD.lives = 5
	startnextgame()

func startnextgame():
	if curgame != null:
		curgame.hide()
		curgame.queue_free()
	#await get_tree().create_timer(1).timeout
	var game = nextgame.instantiate()
	game.position = spawnmarker.position
	
	curgame = game
	add_child(game)
	

func gamelost():
	HUD.lives -= 1
	HUD.update_lives_display()
	if HUD.lives > 0:
		startnextgame()
	else:
		gameover()

func gameover():
	pass




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
