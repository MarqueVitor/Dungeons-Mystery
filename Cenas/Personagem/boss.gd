extends CharacterBody2D

class_name boss

@export var gravity_speed:float = 350 # Força da gravidade 
@onready var ray_cast_2d = $RayCast2D
@onready var healthbat = $healthbat
@onready var animation_player = $AnimationPlayer
@onready var texture = $Texture

enum {
	IDLE,WALK,DEATH,ATTACK,HIT
}

@export var health: int = 2
@export var life = 4
var state = WALK
const SPEED = 70.0
var is_moving_left = true
var dead = false 

func _physics_process(delta:float)->void:
	bar_life()
	if not is_on_floor():
		velocity.y += delta * gravity_speed
		
	match state:
		IDLE:
			animation_player.stop
		WALK:
			animation_player.play("Walk")
			velocity.x = SPEED if is_moving_left else -SPEED
			detection_turn_around()
		ATTACK:
			animation_player.play("Attack")
			velocity.x = 0
		DEATH: 
			animation_player.play("Death")
			state = IDLE
			velocity.x = 0
		HIT:
			pass
			
	move_and_slide()

# Função para mudar o inimigo de direção
func detection_turn_around()->void:
	if not ray_cast_2d.is_colliding() and is_on_floor():
		is_moving_left = !is_moving_left
		flip()
		velocity.x = SPEED if is_moving_left else -SPEED
		
 #Função para virar o inimigo
func flip()->void:
	if velocity.x > 0:
		texture.flip_h=true
	if velocity.x<0:
		texture.flip_h=false

#Atualiza a vida do inimigo
func update_life(dano:int)->void:
	if life != 0:
		life -= dano
		healthbat.value=life
	if life == 0:
		state=DEATH

func bar_life()->void:
	if life>0:
		healthbat.visible= true
	else:
		healthbat.visible= false
		
func _on_detection_body_entered(body)->void:
	if life == 0:
		queue_free()
		return
	if body.is_in_group("guerreiro_main"):
		state=ATTACK
		body.update_health(global_position,health,"decrease")


func _on_detection_body_exited(body)->void:
	if life == 0:
		queue_free()
		return
	if body.is_in_group("guerreiro_main"):
		state=WALK
