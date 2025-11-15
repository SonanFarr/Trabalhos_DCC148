extends Area2D

#@export var speed : float
var speed = 200

var target := Vector2.ZERO

func set_target(p: Vector2) -> void:
	target = p

func _process(delta: float) -> void:
	var dir = (target - global_position).normalized()
	global_position += dir * speed * delta
	
	if process_mode == Node.PROCESS_MODE_INHERIT:
				if global_position.distance_to(target) < 10:
					hide()
					process_mode = Node.PROCESS_MODE_DISABLED
