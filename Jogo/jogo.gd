extends Node2D

@onready var spawner : Spawner = $SpawnerDeInimigos
@onready var player : CharacterBody2D = $CharacterBody2D
@onready var ui : UI = $UI

@export var carro_default : Carro 
@export var forcar_inicio : bool

var player_morreu = false

var posicao_inicial : Vector2 = Vector2.ZERO

func _ready() -> void:
	player.visible = false
	posicao_inicial = player.global_position
	spawner.ativar = false
	
	if forcar_inicio:
		$UI.esconder_menu()
		_on_ui_iniciar_jogo(carro_default)

func _on_spawner_de_inimigos_spawnar_inimigo(inimigo: Variant, 
											 posicao: Variant) -> void: #.
	add_child(inimigo)
	inimigo.set_deferred("global_position", posicao)
	print("Carro do ovo")

func _on_timer_timeout() -> void:
	spawner.diminuir_tempo()

func _on_despawner_body_entered(body: Node2D) -> void:
	print("despawner")
	body.queue_free()
	
	if not player_morreu:
		ui.atualizar_placar()

func _on_character_body_2d_morreu() -> void:
	player_morreu = true
	spawner.ativar = false

func _on_ui_iniciar_jogo(carro: Carro) -> void:
	player.configurar_carro(carro)
	spawner.resetar_tempo()
	player.global_position = posicao_inicial
	spawner.ativar = true
	player_morreu = false
	
func _on_ui_resetar_jogo() -> void:
	
	get_tree().call_group("INIMIGO", "queue_free")
	
	player_morreu = false
	
	spawner.resetar_tempo()
	spawner.ativar = true
	
	player.reviver()
	player.global_position = posicao_inicial
	
