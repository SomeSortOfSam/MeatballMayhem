extends Control

export(String, FILE, "*.tscn") var nextLevel
export(String, FILE, "*.tscn") var settingsMenu
export(String, FILE, "*.tscn") var credits


func _on_Exit_pressed():
	get_tree().quit()


func _on_PlayGame_pressed():
	get_tree().change_scene(nextLevel)


func _on_Credits_pressed():
	get_tree().change_scene(credits)
