extends KinematicBody2D


var path
var velocity
var move_speed


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if path == null:
		return
	if path.size() > 1:
		velocity = self.global_position.direction_to(path[1])
#			rotation = lerp(rotation, global_position.direction_to(path[1]).angle(), 0.1)
		move_and_slide(velocity.normalized() * move_speed)
		if velocity.x < 0:
			scale.x = scale.y * -1
		elif velocity.x > 0:
			scale.x = scale.y * 1
#			yield(get_tree().create_timer(0.3), "timeout")
		var distance_to_point = get_global_position().distance_to(path[1])
		if distance_to_point < 2:
			path.remove(1)
	else:
		emit_signal("reached_point")
