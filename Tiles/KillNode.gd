extends Area2D

onready var platform = $StaticBody2D/CollisionShape2D
onready var sprite = $Sprite
onready var hurtbox = $CollisionShape2D

func _on_Kill_body_entered(body):
	body.kill()
	hurtbox.set_deferred("disabled",false)
	platform.shape.set_extents(Vector2(32,32))
	platform.set_position(Vector2(32,32))
