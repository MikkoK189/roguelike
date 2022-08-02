extends Node2D


export var paths_to_tiles = [""]
export var tile_size_x = 8
export var tile_size_y = 8
export var tile_offset_x = 0
export var tile_offset_y = 0

onready var tileSample = preload("res://Tile.tscn")
onready var chunk = get_parent()

var tile_textures = []


func _ready():
	for tile in paths_to_tiles:
		tile_textures.append(load(tile))
