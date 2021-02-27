extends Area2D

func _on_Destroy_body_entered(body):
	body.kill()
