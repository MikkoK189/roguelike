extends Node2D
var noise = OpenSimplexNoise.new()
var map_seed = "mikko"

const size = 256
var world = []
onready var tilemap = $TileMap

func _ready():
	noise.octaves = 4
	noise.period = 20.0
	noise.persistence = 0.8
	generate_world(size)
	pass


func generate_world(size):
	for x in size:
		for y in size:
			var val = noise.get_noise_2d(x, y)
			if(val > 0):
				tilemap.set_cell(x, y, 1) 
			else:
				tilemap.set_cell(x, y, 0)
