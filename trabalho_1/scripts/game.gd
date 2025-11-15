extends Node2D

@export var objeto : PackedScene
@export var num_objetos : int
var pool : ObjectPool

func _ready() -> void:
	pool = ObjectPool.new(objeto, num_objetos, "Enemy", self)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("create_enemy"):
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
