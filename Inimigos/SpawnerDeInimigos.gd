extends Node2D
class_name Spawner

const TEMPO_MINIMO : float = 0.5
const TEMPO_MAXIMO : float = 5.0
const TEMPO_PASSO : float = 0.15

signal spawnar_inimigo(inimigo, posicao)

@export var possiveis_inimigos : Array[PackedScene] = []
@export var possibilidades_inimigos : Array[float]
@export_range(TEMPO_MINIMO, TEMPO_MAXIMO, TEMPO_PASSO) var tempo_espera : float = 5 : set =_set_tempo_espera
@onready var timer : Timer = $Timer

var spawns : Array[Node]
@export var ativar : bool = false : set = _set_ativar

var tempo_espera_inicial : float 

func _ready() -> void:
	randomize()
	
	tempo_espera_inicial = tempo_espera
	
	var filhos : Array[Node]= get_children()
	spawns = filhos.filter(_filtrar_marcadores)
	timer.paused = not ativar
	
func resetar_tempo() -> void:
	tempo_espera = tempo_espera_inicial
	
func _set_tempo_espera(set_tempo: float) -> void:
	tempo_espera = clamp(set_tempo, TEMPO_MINIMO, TEMPO_MAXIMO)
	print("tempo espera: ",tempo_espera)
	$Timer.wait_time = tempo_espera
	
func _set_ativar(p_ativar: bool) -> void:
	ativar = p_ativar
	$Timer.paused = not ativar

func diminuir_tempo():
	if not ativar:
		return
	
	tempo_espera = clamp(tempo_espera - TEMPO_PASSO, TEMPO_MINIMO, TEMPO_MAXIMO)

func _filtrar_marcadores(node: Node) -> bool:
	return node is Marker2D

func _on_timer_timeout() -> void:

	if possiveis_inimigos.is_empty():
		printerr("deu ruim")
		return
		
	var chance_spawn = randf_range(0,1)
	var inimigo_cena : PackedScene
	
	for idx in range(possiveis_inimigos.size()):
		
		if chance_spawn > possibilidades_inimigos[idx]:
			continue
			
		inimigo_cena = possiveis_inimigos[idx]
		break
	
	if not inimigo_cena:
		return
		
	var inimigo_instancia = inimigo_cena.instantiate()
	
	spawnar_inimigo.emit(inimigo_instancia, 
						spawns.pick_random().global_position)
	
	
