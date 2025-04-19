extends CharacterBody2D

signal morreu()

var SPEED = 50
var STIFFNESS := 0.97
var ACCELERATION := 10.0

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

func configurar_carro(carro_config: Carro) -> void:
	sprite.texture = carro_config.textura
	SPEED = carro_config.velocidade
	STIFFNESS = carro_config.rigidez
	visible = true
	
func reviver() -> void:
	visible = true
	collision.set_deferred("disabled", false)

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	direction = direction.normalized()
	
	velocity.y = lerp(velocity.y, direction.y* SPEED * STIFFNESS, STIFFNESS * delta)
	velocity.x = lerp(velocity.x, direction.x * SPEED, ACCELERATION * delta)
	move_and_slide()

func _on_colisao_inimigo_body_entered(body: Node2D) -> void:
	if not visible:
		return
	morreu.emit()
	visible = false
	collision.set_deferred("disabled", true)
	
