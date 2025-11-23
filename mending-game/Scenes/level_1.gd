extends Node2D


var games = {
	"diagnose":{"path":"res://minigames/click_correct_arrow.tscn", "text":"Cure!"},
	}
var nextgame = load(games["diagnose"])
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
		curgame.queue_free()
	var game = nextgame.instantiate()
	game.position = spawnmarker.position
	
	curgame = game
	add_child(game)
	
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
