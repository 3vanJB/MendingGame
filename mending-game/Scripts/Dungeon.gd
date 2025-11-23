extends Node2D
@onready var game_marker: Marker2D = $MinigamePoint
@onready var player:AnimationPlayer = $Prompt/PromptPlayer
var collection :Dictionary={
	1:"res://minigames/click_correct_arrow.tscn",
	2:"res://minigames/click_random_buttons.tscn"
}

func _ready() -> void:
	minigame()

func minigame():
	var chance = randi() % 2 + 1
	player.play("Appear")
	#/*
	if chance == 1:
		$Prompt.text = "Click!"
	elif chance == 2:
		$Prompt.text = "Diagnose!"
	#*/
	player.play("Fade")
	$"Game Timer"
	var scene = load(collection[chance])
	var instance = scene.instantiate()
	add_child(instance)
