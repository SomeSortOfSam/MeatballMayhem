extends Area2D


func _on_Oven_body_entered(body):
	body.cook()
