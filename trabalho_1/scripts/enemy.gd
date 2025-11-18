extends Area2D

var speed := 200

var origin: Vector2
var target := Vector2.ZERO
var recuo_target: Vector2
var is_recuing := false

var sprite
var original_scale: Vector2
var min_scale := Vector2(0.3, 0.3)

var scenario := "day"
var fog_marker_y := 0.0

func _ready() -> void:
	add_to_group("enemies")

	sprite = get_node("Sprite2D")
	original_scale = sprite.scale

func set_target(p: Vector2) -> void:
	target = p
	origin = global_position
	sprite.scale = min_scale

func _process(delta: float) -> void:
	var dir = (target - global_position).normalized()
	
	if scenario == "day":
		self.sprite.texture = load("res://assets/enemy/enemy.png")
	
	if scenario == "fog":
		self.sprite.texture = load("res://assets/enemy/enemy.png")
		if global_position.y >= fog_marker_y:
			self.show()
		else:
			self.hide()
			
	if scenario == "night":
		self.sprite.texture = load("res://assets/enemy/enemy_night.png")
		if global_position.y >= fog_marker_y:
			self.sprite.texture = load("res://assets/enemy/enemy.png")
		else:
			self.sprite.texture = load("res://assets/enemy/enemy_night.png")
	
	if is_recuing:
		global_position = global_position.move_toward(recuo_target, speed * delta)

		var dist_atual = global_position.distance_to(target)
		var dist_total = origin.distance_to(target)
		var t = clamp(dist_atual / dist_total, 0.0, 1.0)

		sprite.scale = min_scale.lerp(original_scale, 1.0 - t)

		if global_position.distance_to(recuo_target) < 1.0:
			is_recuing = false
		return

	global_position += dir * speed * delta

	var dist_atual = global_position.distance_to(target)
	var dist_total = origin.distance_to(target)
	var t = clamp(dist_atual / dist_total, 0.0, 1.0)

	sprite.scale = min_scale.lerp(original_scale, 1.0 - t)

	if process_mode == Node.PROCESS_MODE_INHERIT:
		if global_position.distance_to(target) < 10:
			hide()
			process_mode = Node.PROCESS_MODE_DISABLED

func retroceder(frac: float) -> void:
	var dist = global_position.distance_to(origin)
	var recuar_dist = dist * frac

	recuo_target = global_position.move_toward(origin, recuar_dist)

	is_recuing = true
