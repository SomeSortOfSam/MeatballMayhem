extends Control


export(String, FILE, "*.tscn") var mainMenu

func _on_Back_pressed():
	get_tree().change_scene(mainMenu)
