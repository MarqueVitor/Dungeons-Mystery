extends CanvasLayer

@onready var animation: AnimationPlayer = get_node("Animation")
signal start_level
var target_path: String
var current_life:int = 0 # Utilizar para manter vida ao trocar de fase 


func fade_in() ->void:
	animation.play("fade_in")

func _on_animation_finished(anim_name:String) ->void:
	if anim_name == "fade_in":
		var _change_scene:bool = get_tree().change_scene_to_file(target_path)
		animation.play("fade_out")
	
	if anim_name == "fade_out":
		var _star: bool = emit_signal("start_level")

func reset()->void: # Reseta a vida caso o personagem morra 
	current_life=0
