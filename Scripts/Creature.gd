extends Node2D
class_name Creature

export var health = 10
export var is_player = false
var world
var chunkmanager
var can_move = true

func _ready():
	yield(get_tree(), "idle_frame")
	chunkmanager = Globals.chunkmanager
	world = Globals.world
	if !is_player:
		Globals.connect("player_action_taken", self, "_take_turn")

func _move(pos : Vector2):
	var map = world.chunkmanager.get_current_chunk(self.global_position).get_node("Map")
	var x = self.global_position.x / Tiles.tile_size_x + pos.x - (chunkmanager.current_chunk.x * chunkmanager.chunk_size / Tiles.tile_size_x)
	var y = self.global_position.y / Tiles.tile_size_y + pos.y - (chunkmanager.current_chunk.y * chunkmanager.chunk_size / Tiles.tile_size_y)
	if(world.chunkmanager.current_chunk != world.chunkmanager.get_current_chunk(Vector2(self.global_position.x + (pos.x * Tiles.tile_size_x) + 1, self.global_position.y + (pos.y * Tiles.tile_size_y) + 1)).chunk_coords):
		var newchunk = world.chunkmanager.get_current_chunk(Vector2(self.global_position.x + (pos.x * Tiles.tile_size_x) + 1, self.global_position.y + (pos.y * Tiles.tile_size_y) + 1))
		map = newchunk.get_node("Map")
		x = self.global_position.x / Tiles.tile_size_x + pos.x - (newchunk.chunk_coords.x * chunkmanager.chunk_size / Tiles.tile_size_x)
		y = self.global_position.y / Tiles.tile_size_y + pos.y - (newchunk.chunk_coords.y * chunkmanager.chunk_size / Tiles.tile_size_y)
	
	var tile_id = map.get_tile(Vector2(x, y))
	if (!Tiles.obstacle_tiles.has(tile_id)):
		self.global_position += pos * Vector2(Tiles.tile_size_x, Tiles.tile_size_y)
		can_move = false
	else:
		return

func _take_turn():
	print("My turn")
	pass
