extends Area2D


@export var health: int = 2

# Função para adionar mais 1 de vida ao personagem
func _on_body_entered(body):
	if body.is_in_group("guerreiro_main"):
		body.update_health(global_position,health,"increase")
		queue_free()
