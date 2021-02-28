extends TextureRect

onready var animation = $AnimationPlayer
onready var timer = $Timer

export(Array, Texture) var textures

export(bool) var requireSalt
export(bool) var requireGarnish

func update_texture():
	var n = 0
	if requireSalt:
		n += 1
	if requireGarnish:
		n += 2
	texture = textures[n]

func _on_Timer_timeout():
	animation.play("End")

func _on_AnimationPlayer_animation_finished(anim_name):
	timer.start(2)
