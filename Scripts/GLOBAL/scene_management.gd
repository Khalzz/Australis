extends Node

## This script is mainly dedicated to load the scenes once and then just open them as packed
enum Scenes {
	ShipRooms,
	ShipTop,
	FirstDay,
	Main,
	Home,
	Exploration,
	ExplorationTutorial,
	StartMessage,
	TutorialMessage,
}

var packed_scenes = {
	Scenes.ShipRooms: {
		"scene": load("res://Scenes/Levels/ShipRooms.tscn"),
		"path": "res://Scenes/Levels/ShipRooms.tscn"
	},
	Scenes.ShipTop:{
		"scene": load("res://Scenes/Levels/ShipTop.tscn"),
		"path": "res://Scenes/Levels/ShipTop.tscn"
	}, 
	Scenes.FirstDay:{
		"scene": load("res://Scenes/Levels/FirstDay.tscn"),
		"path": "res://Scenes/Levels/FirstDay.tscn"
	}, 
	Scenes.Main:{
		"scene": load("res://Scenes/Levels/Main.tscn"),
		"path": "res://Scenes/Levels/Main.tscn"
	}, 
	Scenes.Home:{
		"scene": load("res://Scenes/Levels/Home.tscn"),
		"path": "res://Scenes/Levels/Home.tscn"
	}, 
	Scenes.Exploration:{
		"scene":  load("res://Scenes/Levels/Exploration.tscn"),
		"path": "res://Scenes/Levels/Exploration.tscn"
	},
	Scenes.ExplorationTutorial:{
		"scene": load("res://Scenes/Levels/ExplorationTutorial.tscn"),
		"path": "res://Scenes/Levels/ExplorationTutorial.tscn"
	},
	Scenes.StartMessage:{
		"scene": load("res://Scenes/Levels/StartMessage.tscn"),
		"path": "res://Scenes/Levels/StartMessage.tscn"
	}, 
	Scenes.TutorialMessage:{
		"scene": load("res://Scenes/Levels/TutorialMessage.tscn"),
		"path": "res://Scenes/Levels/TutorialMessage.tscn"
	}, 
}
