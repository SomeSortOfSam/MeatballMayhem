extends Area2D

onready var sprite = $Sprite

var meatball

func _on_Shaker_body_entered(body):
	sprite.play("shake")
	meatball = body

func _on_Sprite_animation_finished():
	meatball.salt()
	sprite.playing = false
	sprite.frame = 0
