extends Node2D
var noise = OpenSimplexNoise.new()
var map_seed = "mikko"

const size = 256
var world = []
onready var tilemap = $TileMap
onready var map = $Node2D

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
				#tilemap.set_cell(x, y, 1) 
				map.set_cell(x, y, 1)
				map.set_cell_modulate(x, y, Color("#2D912C"))
				pass
			elif(val < 0 && val > -0.3):
				#tilemap.set_cell(x, y, 0)
				map.set_cell(x, y, 0)
				map.set_cell_modulate(x, y, Color("#E1C288"))
			elif(val < -0.3 ):
				map.set_cell(x, y, 2)
				map.set_cell_modulate(x, y, Color("#00AAC0"))
			if (val > 0.15):
				map.set_cell_modulate(x, y, Color("#67AF66"))
			if (val > 0.25):
				map.set_cell_modulate(x, y, Color("#94C793"))

			
