extends Node2D

onready var chunk = get_parent()

var tile_textures = []
var tiles = {}
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
		tiles[Vector2(x, y)] = sprite
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
		tiles[Vector2(x, y)] = sprite
		sprite.texture = Tiles.tile_textures[index]
		sprite.position.x = (x * Tiles.tile_size_x) + (Tiles.tile_size_x / 2) + Tiles.tile_offset_x
		sprite.position.y = (y * Tiles.tile_size_y) + (Tiles.tile_size_y / 2) + Tiles.tile_offset_y
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
	if(tiles.has(Vector2(pos.x, pos.y))):
		return tiles[Vector2(pos.x, pos.y)].id
	pass
