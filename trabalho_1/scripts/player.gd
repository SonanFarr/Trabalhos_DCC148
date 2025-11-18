extends Area2D

@export var speed : float

var screen : Rect2
var ground : float
var game : Node

func _ready() -> void:
	game = get_tree().current_scene
	connect("area_entered", Callable(self, "_on_area_entered")) 


func _process(delta: float) -> void:
	var dx = Input.get_axis("player_left", "player_right")
	position.x += dx * speed * delta
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		game.retroceder_inimigos()
		game.update_life()
