extends Area2D

onready var timer = $Timer
onready var sprite = $Sprite

export(String, FILE, "*.tscn") var nextLevel


func _on_Level_Win_body_entered(body):
	if body.cooked:
		get_tree().change_scene(nextLevel)
	else:
		sprite.frame = 0
		timer.start(1)

func _on_Timer_timeout():
	sprite.frame = 1
