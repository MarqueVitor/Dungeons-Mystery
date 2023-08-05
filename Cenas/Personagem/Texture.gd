extends Sprite2D

# Variavel para conseguir utilizar as animações criadas
@export var animation: AnimationPlayer = null
@export var guerreiro_main: CharacterBody2D = null
var on_action: bool = false
var target_path

# Com o valor retornado é possivel saber qual função será de retorno
func animate(velocity: Vector2) -> void:
	change_orientation(velocity.x)
	if on_action:
		return
		
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
		
	
# Faz verificação e chama as animações
func horizontal_move(direction:float) -> void:
	if direction != 0:
		animation.play("Run")
		return	
	animation.play("Idle")
	
func action_behavior(action:String) ->void:
	animation.play(action)
	on_action = true
	
func _on_animation_animation_finished(anim_name:String):
	on_action = false
	if anim_name == "Climb":
		guerreiro_main.climbind=false
	if anim_name =="Hit":
		guerreiro_main.on_knockback=false
	if anim_name =="Death": # Caso o personagem morra, ele reinicia a cena
		hide()
		transition_screen.fade_in()
		#var _reload : bool = get_tree().reload_current_scene()
	if anim_name == "Pray":
		transition_screen.fade_in()
		

