extends Area2D

@export var velocidade : float

var direcao = Vector2.RIGHT

func _process(delta: float) -> void:
	global_translate(direcao * velocidade * delta)
