extends Area2D

onready var timer = $Timer
onready var sprite = $Sprite

export(String, FILE, "*.tscn") var nextLevel

onready var audio = $AudioStreamPlayer2D

export(bool) var requireSalt = false
export(bool) var requireGarnish = false

func _on_Level_Win_body_entered(body):
	if !body.cooked:
		sprite.frame = 1
		timer.start(1)
	elif (requireSalt && !body.salted) || (!requireSalt && body.salted):
		sprite.frame = 2
		timer.start(1)
	elif (requireGarnish && !body.garnished) || (!requireGarnish && body.garnished):
		sprite.frame = 3
		timer.start(1)
	else:
		audio.play()
		get_tree().change_scene(nextLevel)

func _on_Timer_timeout():
	sprite.frame = 0



	
