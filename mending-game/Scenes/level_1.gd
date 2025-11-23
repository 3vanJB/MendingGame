extends Node2D


var games = {
	"diagnose":"res://minigames/click_correct_arrow.tscn",
	}
var nextgame = load(games["diagnose"])
@onready var HUD = $HUD
@onready var spawnmarker = $GameSpawn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HUD.lives = 5
	startnextgame()

func startnextgame():
	var game = nextgame.instantiate()
	game.position = spawnmarker.position
	add_child(game)
	
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
