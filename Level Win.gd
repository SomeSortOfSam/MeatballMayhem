extends Area2D

export(String, FILE, "*.tscn") var nextLevel

func _on_Level_Win_body_entered(body):
	get_tree().change_scene(nextLevel)
