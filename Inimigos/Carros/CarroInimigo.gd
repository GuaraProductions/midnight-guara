extends CharacterBody2D
class_name Inimigo

const NOME_GRUPO = "INIMIGO"

@export var SPEED : float = 300.0

@export var direction : Vector2 = Vector2(-1,0)

func _ready() -> void:
	add_to_group(NOME_GRUPO)

func _physics_process(delta: float) -> void:
	
	velocity = direction * SPEED

	move_and_slide()
