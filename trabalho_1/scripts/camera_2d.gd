extends Camera2D

@export var speed : float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#position.x += speed * delta * Input.get_axis("player_left", "player_right")
