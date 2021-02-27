extends Area2D

onready var platform = $StaticBody2D/CollisionShape2D
onready var sprite = $Sprite

func _on_Kill_body_entered(body):
	body.kill()
	platform.set_deferred("disabled",false)
	sprite.set_self_modulate(Color.green)
