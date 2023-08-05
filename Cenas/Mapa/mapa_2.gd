extends Node2D

@export var scene_path: String
@onready var player: CharacterBody2D = get_node("GuerreiroMain")
@onready var interface: CanvasLayer = get_node("Interface")

# Função para chamar as transições de tela 
func _ready() ->void:
	$Battle.play()
	interface.update_health(player.max_health) # Carrega na interface com a vida atual
	transition_screen.target_path=scene_path
	transition_screen.connect(
		"start_level", Callable(self,"start_level")
	)
	if transition_screen.current_life != 0: # Armazena a vida atual para troca de fases
		player.health= transition_screen.current_life
		interface.update_health(transition_screen.current_life)
	
func star_level() ->void:
	print("Colocar aqui se utilizar outras animações")
