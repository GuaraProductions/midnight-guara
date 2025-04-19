extends Resource
class_name Carro

@export var nome : String = ""
@export_range(1,10000, 0.1) var velocidade : float = 5.0
@export_range(0.1,0.99,0.01) var rigidez : float = 0.97
@export var textura : Texture2D
@export var preco : float = 0.0


func _init(p_nome: String = "", 
		   p_velocidade: float = 5,
		   p_rigidez: float = .97, 
		   p_textura: Texture2D = null,
		   p_preco: float = 0.0) -> void:
	nome = p_nome
	velocidade = p_velocidade
	rigidez = p_rigidez
	textura = p_textura
	preco = p_preco

func eh_gratuito() -> bool:
	return preco <= 0
