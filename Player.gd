extends Node2D

onready var map = get_parent().get_node("Map")
onready var world = get_parent()

func _ready():
	if(map.get_tile(world.size / 2, world.size / 2) != 0):
		self.global_position = Vector2(world.size / 2 * 8, world.size / 2 * 8)
	print(map)

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
	if (map.get_tile((self.global_position.x / 8) + pos.x, (self.global_position.y / 8) + pos.y) != 0):
		self.global_position += pos * 8
	else:
		return
	pass
