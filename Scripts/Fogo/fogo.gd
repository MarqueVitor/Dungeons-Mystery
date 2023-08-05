extends StaticBody2D

@onready var tempo_fogo: Timer = get_node("Timer")
@onready var animation: AnimationPlayer = get_node("Animation")

var estado_atual: String = "Off"

@export var demage: int

func _ready():
	tempo_fogo.start()

func _on_timer_timeout():
	
	#state_timer.start() Descomentar para o fogo ligar/desligar e mudar wait time
	if estado_atual == "Off":
		estado_atual  = "On"
		animation.play(estado_atual)
		return
		
	if estado_atual  == "On":
		estado_atual  = "Off"
		animation.play(estado_atual)
		return

func _on_area_2d_body_entered(body):
	if body.is_in_group("guerreiro_main"):
		body.update_health(global_position,demage,"decrease")
