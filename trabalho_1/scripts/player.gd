extends Area2D

@export var speed : float

var screen : Rect2
var ground : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dx = Input.get_axis("player_left", "player_right")
	
	position.x += dx * speed * delta
