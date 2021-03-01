extends Area2D

onready var sprite = $Sprite

var meatball

func _on_Sprite_animation_finished():
	meatball.garnish()
	sprite.playing = false
	sprite.frame = 0

func _on_Garnisher_body_entered(body):
	sprite.play("Garnish")
	meatball = body
