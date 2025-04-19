extends MarginContainer

@export var carros : Array[Carro]

@export var carro_card : PackedScene

@onready var grid_carro : HFlowContainer = %GridCarros
@onready var dinheiro : Label = %DinheiroLabel

func atualizar_dinheiro(p_dinheiro):
	%DinheiroLabel.text = "Saldo: %d" % p_dinheiro


func atualizar_carros() :
	remover_carros_cards()
	var carteira = get_parent().carteira
	
	for carro in carros:
		var button : Button = carro_card.instantiate()
		
		var usuario_tem_carro = carteira.usuario_tem_carro(carro.nome) or carro.eh_gratuito()
		
		button.configurar(carro.textura, 
					 carro.preco, 
					 usuario_tem_carro)
		
		button.pressed.connect(carro_selecionado.bind(button, carro))
		
		grid_carro.add_child.call_deferred(button)
		
	
func carro_selecionado(card, carro):
	
	if card.comprado:
		get_parent().carro_selecionado(carro)
		
	else:
		var carteira = get_parent().carteira
		var comprou = carteira.tentar_comprar_carro(carro)
		
		if comprou:
			card.comprado = true
			atualizar_dinheiro(get_parent().carteira.dinheiro)
			
func remover_carros_cards():
	
	for child in grid_carro.get_children():
		child.queue_free()
