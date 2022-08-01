extends Node2D

export var tile_size_x = 32
export var tile_size_y = 32
export var tile_offset_x = 0
export var tile_offset_y = 0

export var paths_to_tiles = [""]
var tile_textures = []

var tiles = {}

func _ready():
	for tile in paths_to_tiles:
		tile_textures.append(load(tile))

func set_cell(x, y, index):
	if(index == -1):
		if(tiles.has(Vector2(x, y))):
			tiles[Vector2(x, y)].queue_free()
	elif(index >= 0):
		var sprite = Sprite.new()
		sprite.visible = false
		tiles[Vector2(x, y)] = sprite
		sprite.texture = tile_textures[index]
		sprite.position.x = (x * tile_size_x) + tile_offset_x
		sprite.position.y = (y * tile_size_y) + tile_offset_y
		sprite.visible = true
		add_child(sprite)
	else:
		get_tree().quit()

func set_cellm(x, y, index, col):
	if(index == -1):
		if(tiles.has(Vector2(x, y))):
			tiles[Vector2(x, y)].queue_free()
	elif(index >= 0):
		var sprite = Sprite.new()
		sprite.visible = false
		tiles[Vector2(x, y)] = sprite
		sprite.texture = tile_textures[index]
		sprite.position.x = (x * tile_size_x) + (tile_size_x / 2) + tile_offset_x
		sprite.position.y = (y * tile_size_y) + (tile_size_y / 2) + tile_offset_y
		sprite.modulate = col
		sprite.visible = true
		add_child(sprite)
	else:
		get_tree().quit()

func set_cell_modulate(x, y, col):
	if(tiles.has(Vector2(x, y))):
		tiles[Vector2(x, y)].modulate = col
