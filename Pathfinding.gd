extends Node2D
class_name Pathfinding


var astar = AStar2D.new()

func _ready():
	Globals.pathfinding = self

func add_cell(x, y, wall):
	var id = get_id_for_point(Vector2(x, y))
	if (wall):
		return
	else:
		astar.add_point(id, Vector2(x, y), 0)


func connect_traversable_tiles(tiles : Array):
	for tile in tiles:
		var id = get_id_for_point(tile)
		# Get coordinates of neighboring tiles
		for _x in range(-1, 2):
			for _y in range(-1, 2):
				var target = tile + Vector2(_x, _y)
				var target_id = get_id_for_point(target)
				if tile == target or not astar.has_point(target_id):
					continue
				
				astar.connect_points(id, target_id, true)


func set_navigation_walls():
	for point in astar.get_points():
		var obstacles = get_tree().get_nodes_in_group("obstacles")
		
		for obstacle in obstacles:
			if obstacle is TileMap:
				var walltiles = obstacle.get_used_cells()
				
				for walltile in walltiles:
					var id = get_id_for_point(walltile)
					
					if astar.has_point(id):
						astar.set_point_disabled(id, true)


func update_navigation_map():
	for point in astar.get_points():
		astar.set_point_disabled(point, false)
	var obstacles = get_tree().get_nodes_in_group("obstacles")
	
	for obstacle in obstacles:
		if obstacle is TileMap:
			var walltiles = obstacle.get_used_cells()
			for walltile in walltiles:
				var id = get_id_for_point(walltile)
				if astar.has_point(id):
#					astar.set_point_disabled(id, true)
					astar.set_point_weight_scale(id, 20)
		if obstacle is KinematicBody2D:
			pass
		if obstacle is StaticBody2D:
			var id = get_id_for_point(obstacle.global_position)
			if astar.has_point(id):
				astar.set_point_disabled(id, true)



func get_id_for_point(point: Vector2):
	var x = point.x * 3 + Tiles.tile_size_x / 2
	var y = point.y * 3 * Tiles.tile_size_y / 4
	return abs(x + y * 126)


# Both start and end are world coordinated
func get_new_path(start: Vector2, end: Vector2) -> Array:
	var start_tile = start 
	var end_tile = Vector2(end.x / Tiles.tile_size_x, end.y / Tiles.tile_size_y)
	
	
	var start_id = get_id_for_point(start_tile)
	var end_id = get_id_for_point(end_tile)
	
	if not astar.has_point(start_id) or not astar.has_point(end_id):
		return []
	
	var path_map = astar.get_point_path(start_id, end_id)
	
	var path_world = []
	for point in path_map:
		var point_world = point
		path_world.append(point_world)
		
	return path_world





