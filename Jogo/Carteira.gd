extends Node
class_name Carteira

signal dinheiro_atualizado(dinheiro)

const SENHA_CARTEIRA : String = "SenhaSecreta" 
const CAMINHO_CARTEIRA : String = "user://carteira.cfg"

const USUARIO_SECTION : String = "Usuario"
const DINHEIRO_CHAVE : String = "dinheiro"

const CARROS_SECTION : String = "Carros"

var carros_comprados : Array[String] = []
var dinheiro : int = 0 

func carregar_carteira() -> ConfigFile:
	
	var config : ConfigFile = ConfigFile.new()
	var err = config.load_encrypted_pass(CAMINHO_CARTEIRA, SENHA_CARTEIRA)
	
	if err != OK:
		printerr("Erro = ", err)
	
	return config
	
func atualizar_dinheiro(p_dinheiro: int) -> void:
	dinheiro += p_dinheiro
	salvar_carteira()
	
func _ready() -> void:
	
	#DirAccess.remove_absolute(CAMINHO_CARTEIRA)
	
	var config = carregar_carteira()
	
	dinheiro = config.get_value(USUARIO_SECTION, DINHEIRO_CHAVE, 0)
	
	if not config.has_section(CARROS_SECTION):
		return
	
	for car_id in config.get_section_keys(CARROS_SECTION):
		carros_comprados.append(car_id)
		
func salvar_carteira() -> void:
	
	var config = carregar_carteira()
	
	config.set_value(USUARIO_SECTION, DINHEIRO_CHAVE, dinheiro)
	
	for car_id in carros_comprados:
		config.set_value(CARROS_SECTION, car_id, true)
		
	config.save_encrypted_pass(CAMINHO_CARTEIRA, SENHA_CARTEIRA)
	
func tentar_comprar_carro(carro: Carro) -> bool:
	
	if carro.preco > dinheiro:
		return false
	
	dinheiro -= carro.preco
	carros_comprados.append(carro.nome)
	salvar_carteira()
	
	return true
	
func usuario_tem_carro(car_id : String) -> bool:
	return carros_comprados.has(car_id)
