extends Creature

var player
var path
var moved = true

func _ready():
	yield(get_tree(), "idle_frame")
	player = Globals.player
	pass

func _process(delta):
	var x = self.global_position.x / Tiles.tile_size_x 
	var y = self.global_position.y / Tiles.tile_size_y
	if(path && !moved):
		var move_pos = Vector2(path[0].x - x,path[0].y - y)
		if(move_pos == Vector2(0, 0)):
			print("NUOLOL")
			path.remove(0)
			if(path):
				move_pos = Vector2(path[0].x - x,path[0].y - y)
		print(move_pos)
		_move(move_pos)

		moved = true
		$Timer.start()
	elif(!path || path.size() < 7 || global_position.distance_to(player.global_position) > 10 * Tiles.tile_size_x):
		path = Globals.pathfinding.get_new_path(Vector2(x, y), player.global_position)
	pass


func _on_Timer_timeout():
	print("Move timer")
	moved = false
