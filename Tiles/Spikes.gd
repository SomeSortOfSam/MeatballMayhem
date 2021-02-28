extends Area2D

onready var platform = $StaticBody2D/CollisionShape2D
onready var sprite = $Sprite
onready var hurtbox = $HurtBox

var cooked = false

func _on_Kill_body_entered(body):
	body.kill("Spike")
	cooked = body.cooked
	body.sprite.connect("animation_finished", $".", "disable_spikes")
	
func disable_spikes():
	hurtbox.set_deferred("disabled",false)
	platform.shape.set_extents(Vector2(32,32))
	platform.set_position(Vector2.ZERO)
	sprite.frame = 1
	if cooked:
		sprite.frame = 2
