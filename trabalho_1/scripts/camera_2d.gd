extends Camera2D

@export var speed : float

func _process(delta: float) -> void:
	pass
	#position.x += speed * delta * Input.get_axis("player_left", "player_right")
