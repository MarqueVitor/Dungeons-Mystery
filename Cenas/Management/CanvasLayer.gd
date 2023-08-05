extends CanvasLayer

@onready var controles = $Controles
@onready var main = $Main

# Botão de Jogar 
func _on_button_play_pressed()->void:
	get_tree().change_scene_to_file("res://Cenas/Mapa/mapa.tscn")

# Botão para ir para os controles
func _on_button_control_pressed()->void:
	main.visible=false
	controles.visible=true

# Botão para fechar o jogo
func _on_button_quit_pressed()->void:
	get_tree().quit()

# Botão para voltar ao menu 
func _on_button_back_menu_pressed()->void:
	main.visible=true
	controles.visible=false

