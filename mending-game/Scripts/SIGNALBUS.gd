extends Node

var gamescene

func ongamewon():
	gamescene.HUD.incrementscore()
	gamescene.startnextgame()



func ongamelost():
	pass
