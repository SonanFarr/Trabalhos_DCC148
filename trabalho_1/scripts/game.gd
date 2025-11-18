extends Node2D

@export var objeto : PackedScene
@export var num_objetos : int

var pool : ObjectPool
var spawn_timer := 0.0
var spawn_interval := 2.0

var scenarios := ["day", "night", "fog"]
var index_scenario := 0
var time_scenario := 0.0
var change_interval := 10.0

var distance := 0.0
var lifes := 2

func _ready() -> void:
	pool = ObjectPool.new(objeto, num_objetos, "Enemy", self)
	spawn_timer = spawn_interval
	
	change_scenario()
	
	$UI/distance.text = "Distance: " + String.num(distance, 2)
	$UI/lifes.text = "Lives: " + str(lifes)

func change_scenario() -> void:
	var name = scenarios[index_scenario]

	var sky_texrect = $Paralax/sky/TextureRect
	var road_texrect = $Paralax/road/TextureRect

	var path = "res://assets/scenario_%s/" % name

	var sky_path = path + "sky.png"
	var road_path = path + "road.png"

	sky_texrect.texture = load(sky_path)
	road_texrect.texture = load(road_path)

	print("Cenário trocado para:", name)

func _physics_process(delta: float) -> void:
	
	distance += delta * 2
	$UI/distance.text = "Distance: " + String.num(distance, 2)
	
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
			enemy.scenario = scenarios[index_scenario]
			enemy.fog_marker_y = $Markers/fog_marker.global_position.y
	
	time_scenario += delta
	if time_scenario >= change_interval:
		time_scenario = 0
		index_scenario = (index_scenario + 1) % scenarios.size()
		change_scenario()

func retroceder_inimigos() -> void:
	var frac := 0.8
	
	for enemy in pool.lista_objetos:
		if enemy.process_mode == Node.PROCESS_MODE_INHERIT:
			enemy.retroceder(frac)

func update_life() -> void:
	lifes -= 1
	$UI/lifes.text = "Lives: " + str(lifes)

	if lifes <= 0:
		game_over()

func game_over() -> void:
	print("GAME OVER")
	#get_tree().reload_current_scene()
	get_tree().change_scene_to_file("res://scenes/tela_game_over.tscn")
