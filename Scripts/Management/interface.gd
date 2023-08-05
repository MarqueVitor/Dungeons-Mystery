extends CanvasLayer

@onready var health: Label = get_node("Vida")

# Função para atualizar a vida do personagem
func update_health(value:int) ->void:
	health.text= "Vidas:" + str(value)
