extends CanvasLayer
class_name UI

signal iniciar_jogo(carro : Carro)
signal resetar_jogo()

@onready var placar_label : Label = %PlacarLabel
@onready var placar_container : MarginContainer = $Placar
@onready var game_over_label = %GameOverLabel
@onready var game_over = $GameOver
@onready var menu_principal = $MenuPrincipal
@onready var escolha_carros = $Escolha
@onready var virtual_joystick = $"Virtual Joystick"
@onready var placar_final = %PlacarFinal
@onready var creditos = $Creditos

@export var carteira : Carteira

var placar : int = 0

func _ready() -> void:
	mostrar_menu()
	var nodes = get_tree().get_nodes_in_group("RichTextComLink")
	
	for node in nodes:
		node.meta_clicked.connect(link_clicado)

func link_clicado(link: String) -> void:
	OS.shell_open(link)
	
func mostrar_menu() -> void:
	resetar_placar()
	placar_final.visible = false
	placar_container.visible = false
	placar_label.visible = false
	game_over_label.visible = false
	escolha_carros.visible = false
	game_over.visible = false
	menu_principal.visible = true
	virtual_joystick.visible = false
	creditos.visible = false
	
func resetar_placar() -> void:
	placar_label.text = "0"
	placar = 0

func esconder_menu() -> void:
	menu_principal.visible = false
	virtual_joystick.visible = true

func carro_selecionado(carro: Carro) -> void:
	virtual_joystick.visible = true
	escolha_carros.visible = false
	placar_label.visible = true
	placar_container.visible = true
	iniciar_jogo.emit(carro)

func atualizar_placar() -> void:
	placar += 1
	placar_label.text = str(placar)
	
func _mostrar_game_over():
	
	carteira.atualizar_dinheiro(placar)
	escolha_carros.atualizar_dinheiro(carteira.dinheiro)
	
	placar_label.visible = false
	placar_container.visible = false
	virtual_joystick.visible = false
	game_over.visible = true
	game_over_label.visible = true
	placar_final.text = "Placar final: %d" % placar
	placar_final.visible = true

func _on_comecar_pressed() -> void:
	escolha_carros.atualizar_dinheiro(carteira.dinheiro)
	escolha_carros.atualizar_carros()
	menu_principal.visible = false
	escolha_carros.visible = true

func _on_sair_pressed() -> void:
	get_tree().quit()

func _on_resetar_pressed() -> void:
	game_over.visible = false
	virtual_joystick.visible = true
	resetar_placar()
	placar_label.visible = true
	resetar_jogo.emit()

func _on_voltar_menu_pressed() -> void:
	mostrar_menu()

func _on_button_pressed() -> void:
	creditos.visible = false
	menu_principal.visible = true

func _on_creditos_pressed() -> void:
	menu_principal.visible = false
	creditos.visible = true
