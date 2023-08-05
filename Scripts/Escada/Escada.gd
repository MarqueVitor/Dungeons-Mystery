extends Area2D


func _on_body_entered(body):
	if body.name.match("GuerreiroMain"):
		body.ladder = true
		
func _on_body_exited(body):
	if body.name.match("GuerreiroMain"):
		body.ladder = false
