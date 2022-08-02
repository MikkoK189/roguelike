extends Node2D

onready var chunkmanager = get_parent().get_node("ChunkManager")
onready var world = get_parent()

func _ready():
	Globals.player = self
#	print(chunkmanager.current_chunk)
#	if(chunkmanager.current_chunk.get_node("Map").get_tile(world.size / 2, world.size / 2) != 0):
#		self.global_position = Vector2(world.size / 2 * 8, world.size / 2 * 8)
#	print(chunkmanager.current_chunk.get_node("Map"))

func _process(delta):
	if Input.is_action_just_pressed("down"):
		var move_pos = Vector2(0, 1)
		move(move_pos)
	if Input.is_action_just_pressed("left"):
		var move_pos = Vector2(-1, 0)
		move(move_pos)
	if Input.is_action_just_pressed("up"):
		var move_pos = Vector2(0, -1)
		move(move_pos)
	if Input.is_action_just_pressed("right"):
		var move_pos = Vector2(1, 0)
		move(move_pos)

func move(pos : Vector2):
	var map = world.chunkmanager.get_current_chunk(self.global_position).get_node("Map")
	var x = self.global_position.x / 8 + pos.x - (chunkmanager.current_chunk.x * chunkmanager.chunk_size / 8)
	var y = self.global_position.y / 8 + pos.y - (chunkmanager.current_chunk.y * chunkmanager.chunk_size / 8)
	if(world.chunkmanager.current_chunk != world.chunkmanager.get_current_chunk(Vector2(self.global_position.x + (pos.x * 8), self.global_position.y + (pos.y * 8) + 1)).chunk_coords):
		var newchunk = world.chunkmanager.get_current_chunk(Vector2(self.global_position.x + (pos.x * 8), self.global_position.y + (pos.y * 8) + 1))
		map = newchunk.get_node("Map")
		x = self.global_position.x / 8 + pos.x - (newchunk.chunk_coords.x * chunkmanager.chunk_size / 8)
		y = self.global_position.y / 8 + pos.y - (newchunk.chunk_coords.y * chunkmanager.chunk_size / 8)
		print("YEET")
		if y >= world.size:
			y = 0
	if (map.get_tile(Vector2(x, y)) != 0):
		self.global_position += pos * 8
	else:
		return
	pass
