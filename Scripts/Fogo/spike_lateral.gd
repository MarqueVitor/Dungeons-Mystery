extends Area2D

@export var dano: int = 2

func _on_body_entered(body)->void:
	if body.is_in_group("guerreiro_main"):
		body.update_health(global_position,dano,"decrease")

