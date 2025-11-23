extends Node

var gamescene

func ongamewon():
	if gamescene != null:
		gamescene.HUD.incrementscore()
		gamescene.startnextgame()



func ongamelost():
	if gamescene != null:
		gamescene.gamelost()
