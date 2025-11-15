extends Area2D

#@export var speed : float
var speed = 200

var origin: Vector2
var target := Vector2.ZERO
var recuo_target: Vector2
var is_recuing := false

func _ready():
	add_to_group("enemies")

func set_target(p: Vector2) -> void:
	target = p
	origin = global_position

func _process(delta: float) -> void:
	var dir = (target - global_position).normalized()
	
	if is_recuing:
		global_position = global_position.move_toward(recuo_target, speed * delta)
		if global_position.distance_to(recuo_target) < 1.0:
			is_recuing = false
		return
	
	global_position += dir * speed * delta
	
	if process_mode == Node.PROCESS_MODE_INHERIT:
				if global_position.distance_to(target) < 10:
					hide()
					process_mode = Node.PROCESS_MODE_DISABLED

func retroceder(frac: float) -> void:
	var dist = global_position.distance_to(origin)
	var recuar_dist = dist * frac
	
	recuo_target = global_position.move_toward(origin, recuar_dist)
	is_recuing = true
