extends CharacterBody2D

# Guarda ref da textura 
@onready var sprite: Sprite2D = get_node("Texture")
@export var move_speed:float = 90 # Velocidade de movimento
@export var gravity_speed:float = 350 # Força da gravidade 
@export var health:float = 3.0 # Vida do personagem
var max_health: float = 0.0
var jump_count: int = 0
var jump_speed: float = -160.0
var knockback_direction: Vector2
var on_knockback: bool = false
var is_dead: bool = false
var ladder := false
var climbind := false
var dano: int = 1
@onready var healthbar = $healthbar

func _ready() -> void:
	max_health=health # Para o personagem começar com o HP maximo
	
# Chamada a cada frame de execução, contém a lógica do jogo
func _physics_process(delta:float)->void:
	if is_dead:
		return
		
	if on_knockback:
		knockback_move()
	bar_life()
	move()
	velocity.y += delta * gravity_speed
	move_and_slide()
	jump()
	_climb_ladder()
	_attack()
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

# Função para detecção de dano no personagem 
func update_health(_target_position:Vector2,value:int,type:String) -> void:
	if is_dead:
		return
		
	if type == "decrease": # Diminuir a vida
		knockback_direction = (global_position - _target_position).normalized()
		sprite.action_behavior("Hit")
		#on_knockback = true
		print("Recebeu " + str(value) + " de dano")
		health = clamp(health-value,0,max_health) # Restringe a vida em um intervalo
		transition_screen.current_life=health
		get_tree().call_group("interface","update_health",health)
		healthbar.value=health
		print("Vida:",health)
		if health == 0: # Indica que o personagem morreu
			is_dead = true
			sprite.action_behavior("Death")
		return
	
	if type == "increase": #Aumentar a vida
		health = clamp(health+value,0,max_health)
		transition_screen.current_life=health
		sprite.action_behavior("UpHealth")
		get_tree().call_group("interface","update_health",health)
		healthbar.value=health
		print("Vida:",health)
	
# Função de knockback do personagem	
func knockback_move() -> void:
	velocity= knockback_direction
	var _move:= move_and_slide()
	sprite.animate(velocity)

# Função para subir as escadas
func _climb_ladder()->void:
	if Input.is_action_just_pressed("ui_up") and ladder:
		climbind = true
		climber()
		
# Função para subir as escadas
func climber()->void:
	if climbind:
		velocity.y= jump_speed
		sprite.action_behavior("Climb")
		
# Função para chamar atacar 
func _attack()->void:
	if Input.is_action_just_pressed("attack"):
		sprite.action_behavior("Attack")
	if Input.is_action_just_pressed("attack_2"):
		sprite.action_behavior("Attack_2")
		
#Função para dar dano ao inimigo
func _on_attack_area_body_entered(body):
	if body.is_in_group("enemy"): # Grupo de inimigos
		body.update_life(dano)
		
func bar_life()->void:
	if max_health>0:
		healthbar.visible= true
	else:
		healthbar.visible= true
	
