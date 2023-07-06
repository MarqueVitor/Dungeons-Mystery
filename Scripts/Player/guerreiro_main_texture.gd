extends Sprite2D

# Variavel para conseguir utilizar as animações criadas
@export var animation: AnimationPlayer = null

# Com o valor retornado é possivel saber qual função será de retorno
func animate(velocity: Vector2) -> void:
	change_orientation(velocity.x)
	if velocity.y !=0: # Verifica se o personagem está sofendo uma queda
		vertical_move(velocity.y)
		return
	horizontal_move(velocity.x)

# Função para inveter o personagem andando
func change_orientation(direction:float) -> void:
	if direction > 0:
		flip_h = false
	if direction < 0:
		flip_h = true
	
# Faz verificação e chama as animações
func vertical_move(direction:float)->void:
	if direction > 0:
		animation.play("Fall")
	if direction < 0:
		animation.play("Jump")
	
# Float pois está recebendo somente um valor em x
# Faz verificação e chama as animações
func horizontal_move(direction:float) -> void:
	if direction != 0:
		animation.play("Run")
		return 
	animation.play("Idle")
	
	
	
	
	
	
	
