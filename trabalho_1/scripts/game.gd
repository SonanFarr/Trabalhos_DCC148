extends Node2D

@export var objeto : PackedScene
@export var num_objetos : int

var pool : ObjectPool
var spawn_timer := 0.0
var spawn_interval := 5.0

func _ready() -> void:
	pool = ObjectPool.new(objeto, num_objetos, "Enemy", self)
	spawn_timer = spawn_interval

func _physics_process(delta: float) -> void:
	spawn_timer -= delta
	if spawn_timer <= 0:
		spawn_timer = spawn_interval
		var enemy = pool.get_from_pool()
		
		var markers = $Markers
		var spawn_point = markers.get_node("road_top").position
		
		if enemy:
			enemy.global_position = spawn_point
			
			var bottoms = [
				markers.get_node("road_bottom_1"),
				markers.get_node("road_bottom_2"),
				markers.get_node("road_bottom_3")
			]
			
			var target = bottoms[randi() % bottoms.size()].global_position
			enemy.set_target(target)

func retroceder_inimigos() -> void:
	var frac := 0.6
	
	for enemy in pool.lista_objetos:
		if enemy.process_mode == Node.PROCESS_MODE_INHERIT:
			enemy.retroceder(frac)
