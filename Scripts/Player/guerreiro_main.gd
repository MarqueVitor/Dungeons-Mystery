extends CharacterBody2D

# Guarda ref da textura 
@onready var sprite: Sprite2D = get_node("Texture")
@export var move_speed:float = 70
@export var gravity_speed:float = 350
var jump_count: int = 0
var jump_speed: float = -160.0

# Chamada a cada frame de execução, contém a lógica do jogo
func _physics_process(delta:float)->void:
	move()
	velocity.y += delta * gravity_speed
	move_and_slide()
	jump()
	sprite.animate(velocity) # Chamada da função em texture

func move()->void: # Função para movimentar o personagem
	var direction:float = get_direction()
	velocity.x = direction * move_speed
	pass
	
func get_direction()->float: # Função para mover o personagem
	return (
		Input.get_axis("ui_left","ui_right") # Setas do teclado
	)

func jump() ->void: # Função que faz o personagem pular 
	if is_on_floor(): # Verifica se o personagem está no chão
		jump_count = 0
	if Input.is_action_just_pressed("ui_select") and jump_count < 1:
		velocity.y = jump_speed
		jump_count +=1
	
	
	
	
	
	
	
	
	
	
