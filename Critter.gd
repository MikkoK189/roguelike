extends Creature

var player
var path = []
var moved = true

func _ready():
	yield(get_tree(), "idle_frame")
	player = Globals.player
	pass

func _process(_delta):
	var x = self.global_position.x / Tiles.tile_size_x 
	var y = self.global_position.y / Tiles.tile_size_y
	if(path.size() > 1 && !moved):
		var move_pos = Vector2(path[1].x - x,path[1].y - y)
#		if(move_pos == Vector2(0, 0)):
#			path.remove(1)
#			print(Vector2(global_position.x / Tiles.tile_size_x, global_position.y / Tiles.tile_size_y))
#			if(path):
#				move_pos = Vector2(path[1].x - x,path[1].y - y)
		_move(move_pos)
		path.remove(1)
		moved = true
	elif(!path || path.size() < 7 || global_position.distance_to(player.global_position) > 10 * Tiles.tile_size_x):
		path = Globals.pathfinding.get_new_path(Vector2(x, y), player.global_position)
		#print(path)
	pass

func _take_turn():
	._take_turn()
	moved = false
	pass
