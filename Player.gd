extends Node2D

onready var chunkmanager = get_parent().get_node("ChunkManager")
onready var world = get_parent()
onready var timer = $Timer
var can_move = true
func _ready():
	Globals.player = self
	timer.connect("timeout", self, "timer_timeout")
	
#	print(chunkmanager.current_chunk)
#	if(chunkmanager.current_chunk.get_node("Map").get_tile(world.size / 2, world.size / 2) != 0):
#		self.global_position = Vector2(world.size / 2 * 8, world.size / 2 * 8)
#	print(chunkmanager.current_chunk.get_node("Map"))

func _process(delta):
	if Input.is_action_pressed("down"):
		if can_move:
			var move_pos = Vector2(0, 1)
			move(move_pos)
			can_move = false
			timer.start()
	if Input.is_action_pressed("left"):
		if can_move:
			var move_pos = Vector2(-1, 0)
			move(move_pos)
			can_move = false
			timer.start()
	if Input.is_action_pressed("up"):
		if can_move:
			var move_pos = Vector2(0, -1)
			move(move_pos)
			can_move = false
			timer.start()
	if Input.is_action_pressed("right"):
		if can_move:
			var move_pos = Vector2(1, 0)
			move(move_pos)
			can_move = false
			timer.start()

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
#	if y >= world.size:
#			y = 0
#	if x >= world.size:
#			x = 0
	if (map.get_tile(Vector2(x, y)) != 0):
		self.global_position += pos * 8
	else:
		return

func timer_timeout():
	can_move = true
