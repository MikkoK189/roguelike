extends Creature

onready var timer = $Timer

func _ready():
	OS.center_window()
	is_player = true
	Globals.player = self
	timer.connect("timeout", self, "timer_timeout")

func _process(_delta):
	get_inputs()

func get_inputs():
	if(!can_move):
		return
	var move_pos
	if Input.is_action_pressed("upleft") || Input.is_action_pressed("up") && Input.is_action_pressed("left"):
		move_pos = Vector2(-1, -1)
	elif Input.is_action_pressed("downleft") || Input.is_action_pressed("down") && Input.is_action_pressed("left"):
		move_pos = Vector2(-1, 1)
	elif Input.is_action_pressed("downright") || Input.is_action_pressed("down") && Input.is_action_pressed("right"):
		move_pos = Vector2(1, 1)
	elif Input.is_action_pressed("upright") || Input.is_action_pressed("up") && Input.is_action_pressed("right"):
		move_pos = Vector2(1, -1)
	elif Input.is_action_pressed("left"):
		move_pos = Vector2(-1, 0)
	elif Input.is_action_pressed("up"):
		move_pos = Vector2(0, -1)
	elif Input.is_action_pressed("right"):
		move_pos = Vector2(1, 0)
	elif Input.is_action_pressed("down"):
		move_pos = Vector2(0, 1)
	if move_pos:
		_move(move_pos)
		Globals.player_action()
	timer.start()


func timer_timeout():
	can_move = true
