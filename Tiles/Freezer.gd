extends Area2D

onready var Box = preload("res://Meatball/Frozen.tscn")

onready var sprite = $Sprite

export(Texture) var cookedTexture
var entered

func _on_Freezer_body_entered(body):
	body.kill("Freeze")
	body.connect("death",$".","spawn_ice")
	entered = body

func spawn_ice():
	entered.disconnect("death",$".","spawn_ice")
	var box = Box.instance()
	get_tree().current_scene.call_deferred("add_child",box)
	box.cooked = entered.cooked
	box.call_deferred("animate","")
	box.global_position = entered.global_position

func cook():
	sprite.animate("Melt","kill")

