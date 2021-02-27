extends Area2D

export(String, FILE, "*.tscn") var nextLevel

onready var popup = $Popup

func _on_Level_Win_body_entered(body):
	if body.cooked:
		get_tree().change_scene(nextLevel)
	else:
		popup.popup()
