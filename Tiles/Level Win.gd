extends Area2D

onready var timer = $Timer
onready var sprite = $Sprite

export(String, FILE, "*.tscn") var nextLevel

var good = load("res://Sounds/Win.wav")
var bad = load("res://Sounds/Lose.wav")

onready var audio = $AudioStreamPlayer2D

export(bool) var requireSalt = false
export(bool) var requireGarnish = false

func _on_Level_Win_body_entered(body):
	if !body.cooked:
		audio.set_stream(bad)
		audio.play()
		sprite.frame = 1
		timer.start(1)
	elif (requireSalt && !body.salted) || (!requireSalt && body.salted):
		audio.set_stream(bad)
		audio.play()
		sprite.frame = 2
		timer.start(1)
	elif (requireGarnish && !body.garnished) || (!requireGarnish && body.garnished):
		audio.set_stream(bad)
		audio.play()
		sprite.frame = 3
		timer.start(1)
	else:
		audio.set_stream(good)
		audio.play()
		var curScene = get_tree().current_scene
		var audio = curScene.get_node("AudioStreamPlayer")
		curScene.remove_child(audio)
		get_tree().change_scene(nextLevel)
		get_tree().current_scene.call_deferred("add_child",audio)

func _on_Timer_timeout():
	sprite.frame = 0



	
