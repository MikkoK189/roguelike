extends Node2D
var noise = OpenSimplexNoise.new()
var map_seed

export var world_size = 5
var world = []
export (NodePath) onready var chunkmanager_path
var chunkmanager
var generate_tasks = []
#signal finished_generation
#var signal_emitted = false

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

#func _process(delta):
#	if(generate_tasks.size() > 0):
#		if(!generate_tasks[0].target.get_ref()):
#			generate_tasks.remove(0)
#			return
#		generate_world(generate_tasks[0].size, generate_tasks[0].target.get_ref(), generate_tasks[0].offset)
#		generate_tasks[0].source.emit_signal("finished_generating")
#		generate_tasks.remove(0)
#	elif(generate_tasks.size() <= 0 && !signal_emitted):
#		emit_signal("finished_generation")
#		print("FINISH")
#		signal_emitted = true

func add_generate_task(_source, _size, _target, _offset : Vector2):
	generate_tasks.append({source = _source, size = _size, target = weakref(_target), offset = _offset})

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
				target.set_cellm(x, y, 1, Color("#67AF66"))
			if (val > 0.25):
				target.set_cellm(x, y, 1, Color("#94C793"))
