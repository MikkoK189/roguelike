extends Creature

onready var timer = $Timer

func _ready():
	Globals.player = self
	timer.connect("timeout", self, "timer_timeout")

func _process(_delta):
	get_inputs()

func get_inputs():
	if(!can_move):
		return
	if Input.is_action_pressed("upleft") || Input.is_action_pressed("up") && Input.is_action_pressed("left"):
		var move_pos = Vector2(-1, -1)
		_move(move_pos)
	elif Input.is_action_pressed("downleft") || Input.is_action_pressed("down") && Input.is_action_pressed("left"):
		var move_pos = Vector2(-1, 1)
		_move(move_pos)
	elif Input.is_action_pressed("downright") || Input.is_action_pressed("down") && Input.is_action_pressed("right"):
		var move_pos = Vector2(1, 1)
		_move(move_pos)
	elif Input.is_action_pressed("upright") || Input.is_action_pressed("up") && Input.is_action_pressed("right"):
		var move_pos = Vector2(1, -1)
		_move(move_pos)
	elif Input.is_action_pressed("left"):
		var move_pos = Vector2(-1, 0)
		_move(move_pos)
	elif Input.is_action_pressed("up"):
		var move_pos = Vector2(0, -1)
		_move(move_pos)
	elif Input.is_action_pressed("right"):
		var move_pos = Vector2(1, 0)
		_move(move_pos)
	elif Input.is_action_pressed("down"):
		var move_pos = Vector2(0, 1)
		_move(move_pos)
	timer.start()


func timer_timeout():
	can_move = true
