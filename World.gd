extends Node2D
var noise = OpenSimplexNoise.new()
var map_seed

export var world_size = 5
var world = []
export (NodePath) onready var chunkmanager_path
var chunkmanager

func _ready():
	Globals.world = self
	randomize()
	map_seed = randi()
	chunkmanager = get_node(chunkmanager_path)
	noise.seed = map_seed
	print(rand_range(0, randi()))
	noise.octaves = 4
	noise.period = 20.0
	noise.persistence = 0.8
	yield(get_tree(), "idle_frame")
	pass


func generate_world(size, target, offset : Vector2):
	for x in size:
		for y in size:
			var val = noise.get_noise_2d(x + offset.x * chunkmanager.chunk_size / 8, y + offset.y * chunkmanager.chunk_size / 8)
			if(val > -0.1):
				#tilemap.set_cell(x, y, 1) 
				target.set_cellm(x, y, 1, Color("#2D912C"))
				#target.set_cell_modulate(x, y, Color("#2D912C"))
				pass
			elif(val < -0.1 && val > -0.3):
				#tilemap.set_cell(x, y, 0)
				target.set_cellm(x, y, 0, Color("#E1C288"))
				#target.set_cell_modulate(x, y, Color("#E1C288"))
			elif(val < -0.3 ):
				target.set_cellm(x, y, 2, Color("#00AAC0"))
				#target.set_cell_modulate(x, y, Color("#00AAC0"))
			if (val > 0.15):
				target.set_cellm(x, y, 0, Color("#67AF66"))
			if (val > 0.25):
				target.set_cellm(x, y, 0, Color("#94C793"))
