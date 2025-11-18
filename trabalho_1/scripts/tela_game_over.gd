extends Control

var timer := 10.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if (timer <= 0.0):
		get_tree().change_scene_to_file("res://scenes/tela_inicial.tscn")
		
	timer -= delta
	$PanelContainer/counter.text = str(round(timer))
