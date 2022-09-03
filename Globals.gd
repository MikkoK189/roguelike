extends Node


var player
var chunkmanager
var world
var pathfinding

signal player_action_taken

func player_action():
	emit_signal("player_action_taken")
