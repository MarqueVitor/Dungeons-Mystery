extends CharacterBody2D

class_name skeleton

@export var texture:Sprite2D = null
@export var animation:AnimationPlayer=null
@export var gravity_speed:float = 350 # Força da gravidade 

@onready var ray2D = $RayCast2D
var player_ref = null

enum {
	IDLE,WALK,DEATH,ATTACK,HIT
}

@export var health: int = 2
@export var life = 2
var state = WALK
const SPEED = 60.0
var is_moving_left = true
var dead = false 
@onready var health_bar = $healthbar

func _on_detection_body_entered(body) -> void:
	if life == 0:
		queue_free()
		return
	if body.is_in_group("guerreiro_main"):
		player_ref = body
		state=ATTACK
		body.update_health(global_position,health,"decrease")
		
func _on_detection_body_exited(body) ->void:
	if life == 0:
		queue_free()
		return
	if body.is_in_group("guerreiro_main"):
		player_ref = null
		state=WALK

func _physics_process(delta:float)->void:
	bar_life()
	if not is_on_floor():
		velocity.y += delta * gravity_speed
		
	match state:
		IDLE:
			animation.stop
		WALK:
			animation.play("Walk")
			velocity.x = SPEED if is_moving_left else -SPEED
			detection_turn_around()
		ATTACK:
			animation.play("Attack")
			velocity.x = 0
		DEATH: 
			animation.play("Death")
			state = IDLE
			velocity.x = 0
		HIT:
			pass
			
	move_and_slide()

# Função para mudar o inimigo de direção
func detection_turn_around()->void:
	if not ray2D.is_colliding() and is_on_floor():
		is_moving_left = !is_moving_left
		flip()
		velocity.x = SPEED if is_moving_left else -SPEED
		
# Função para virar o inimigo
func flip()->void:
	if velocity.x > 0:
		texture.flip_h=true
	if velocity.x<0:
		texture.flip_h=false

#Atualiza a vida do inimigo
func update_life(dano:int)->void:
	if life != 0:
		$takeHit.play()
		life -= dano
		health_bar.value=life
	if life == 0:
		state=DEATH

func bar_life()->void:
	if life>0:
		health_bar.visible= true
	else:
		health_bar.visible= true
	
