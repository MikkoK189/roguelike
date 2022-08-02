extends Node2D

export(NodePath) var world_path
var world

var chunk_coords = Vector2()
var chunk_data = []
var colors #0


func start(_chunk_coords):
	chunk_coords = _chunk_coords
#	$Coords.text = str(chunk_coords)
	if WorldSave.loaded_coords.find(_chunk_coords) == -1:
		world.generate_world(world.size, $Map, chunk_coords)
		WorldSave.add_chunk(chunk_coords)
	else:
		chunk_data = WorldSave.retrive_data(chunk_coords)
		world.generate_world(world.size, $Map, chunk_coords)


func save():
	WorldSave.save_chunk(chunk_coords, chunk_data)
	queue_free()
