extends Button

var comprado = false : set = _comprado
var preco : float = 0.0

func configurar(texture: Texture2D,
				p_preco: float,
				p_comprado: bool) -> void:
	icon = texture
	preco = p_preco
	comprado = p_comprado

func _comprado(p_comprado):
	comprado = p_comprado

	text = str(preco) if not comprado else ""
	vertical_icon_alignment = VERTICAL_ALIGNMENT_CENTER if comprado else VERTICAL_ALIGNMENT_BOTTOM
	
	if not comprado:
		modulate.a = 0.4
	else:
		modulate = Color.WHITE
	
	
	
