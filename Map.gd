extends Node2D

onready var chunk = get_parent()

var tile_textures = []
var tiles = []
var sampleTile

func _init():
	sampleTile = preload("res://Tile.tscn")
	

func set_cell(x, y, index):
	if(index == -1):
		if(tiles.has(Vector2(x, y))):
			tiles[Vector2(x, y)].queue_free()
	elif(index >= 0):
		var sprite = sampleTile.instance()
		sprite.visible = false
		#tiles[Vector2(x, y)] = sprite
		tiles.append({pos = Vector2(x, y), spr = sprite})
		sprite.texture = Tiles.tile_textures[index]
		sprite.position.x = (x * Tiles.tile_size_x) + Tiles.tile_offset_x
		sprite.position.y = (y * Tiles.tile_size_y) + Tiles.tile_offset_y
		sprite.visible = true
		sprite.id = index
		call_deferred("add_child", sprite)
	else:
		get_tree().quit()

func set_cellm(x, y, index, col):
	if(index == -1):
		if(tiles.has(Vector2(x, y))):
			tiles[Vector2(x, y)].queue_free()
	elif(index >= 0):
		var sprite = sampleTile.instance()
		sprite.visible = false
		#tiles[Vector2(x, y)] = sprite
		tiles.append({pos = Vector2(x, y), spr = sprite})
		sprite.texture = Tiles.tile_textures[index]
		sprite.position.x = (x * Tiles.tile_size_x) + Tiles.tile_offset_x
		sprite.position.y = (y * Tiles.tile_size_y) + Tiles.tile_offset_y
		sprite.modulate = col
		sprite.visible = true
		sprite.id = index
		add_child(sprite)
	else:
		get_tree().quit()

func set_cell_modulate(x, y, col):
	if(tiles.has(Vector2(x, y))):
		tiles[Vector2(x, y)].modulate = col

func get_tile(pos):
	for tile in tiles:
		if(tile.pos == pos):
			return tile.spr.id
	pass


func _on_Chunk_finished_generating():
	var tile_coords = []
	for tile in tiles:
		if(Tiles.obstacle_tiles.has(tile.spr.id)):
			continue
		else:
			Globals.pathfinding.add_cell(tile.spr.global_position.x / Tiles.tile_size_x, tile.spr.global_position.y / Tiles.tile_size_y, false)
			tile_coords.append(Vector2(tile.spr.global_position.x / Tiles.tile_size_x, tile.spr.global_position.y / Tiles.tile_size_y))
	Globals.pathfinding.connect_traversable_tiles(tile_coords)
