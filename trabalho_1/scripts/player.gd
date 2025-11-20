extends Area2D

@export var speed : float

var screen : Rect2
var ground : float
var game : Node

@onready var left_limit: Marker2D = get_parent().get_node("Markers/road_bottom_1")
@onready var right_limit: Marker2D = get_parent().get_node("Markers/road_bottom_3")

func _ready() -> void:
	game = get_tree().current_scene
	connect("area_entered", Callable(self, "_on_area_entered")) 

func blink_player():
	var tween := create_tween()
	var sprite := $Sprite2D

	for i in range(6):
		tween.tween_property(sprite, "modulate:a", 0.2, 0.1)
		tween.tween_property(sprite, "modulate:a", 1.0, 0.1)

func _process(delta: float) -> void:
	var dx = Input.get_axis("player_left", "player_right")
	position.x += dx * speed * delta
	global_position.x = clamp(
		global_position.x,
		left_limit.global_position.x,
		right_limit.global_position.x
	)
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		game.recoil_enemies()
		game.update_life()
		blink_player()
