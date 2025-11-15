extends Node2D

@export var objeto : PackedScene
@export var num_objetos : int
var pool : ObjectPool

func _ready() -> void:
	pool = ObjectPool.new(objeto, num_objetos, "Enemy", self)


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("create_enemy"):
		var enemy = pool.get_from_pool()
		if enemy:
			enemy.global_position = global_position
			print("Enemy created!")
