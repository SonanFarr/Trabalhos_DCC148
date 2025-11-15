class_name ObjectPool

var objeto : PackedScene
var num_objetos : int
var lista_objetos : Array[Node2D]
var nome : String


func _init(objeto, num_objetos, nome, cena: Node) -> void:
	self.objeto = objeto
	self.num_objetos = num_objetos
	self.nome = nome
	
	instancia_objetos(cena)


func instancia_objetos(cena: Node) -> void:
	lista_objetos = []
	for i in range(num_objetos):
		var inst = objeto.instantiate()
		inst.name = nome + str(i)
		inst.hide()
		inst.process_mode = Node.PROCESS_MODE_DISABLED

		cena.add_child.call_deferred(inst)
		lista_objetos.append(inst)


func esta_disponivel(obj: Node2D) -> bool:
	return obj.process_mode == Node.PROCESS_MODE_DISABLED


func get_from_pool() -> Node2D:
	for obj in lista_objetos:
		if esta_disponivel(obj):
			obj.show()
			obj.process_mode = Node.PROCESS_MODE_INHERIT
			return obj

	return null
