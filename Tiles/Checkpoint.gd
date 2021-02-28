extends Area2D

onready var Meatball = preload("res://Meatball/Meatball.tscn")

var curMeatball
var cameraTransform

var was_cooked = false
var was_salted = false
var was_garnished = false

func _on_Checkpoint_body_entered(body):
	if curMeatball == null:
		#disconect previous checkpoint
		body.set_new_checkpoint()
		
		connect_meatball(body)
		was_cooked = body.cooked
		was_salted = body.salted
		was_garnished = body.garnished
		cameraTransform = body.get_node("RemoteTransform2D")
		
		$Sprite.frame = 0
		$AudioStreamPlayer2D.play()

func _on_meatball_death():
	var meatball = Meatball.instance()
	get_tree().current_scene.call_deferred("add_child",meatball)
	meatball.global_position = global_position
	curMeatball.remove_child(cameraTransform)
	curMeatball.queue_free()
	meatball.add_child(cameraTransform)
	
	#Return state
	if was_cooked:
		meatball.cook()
	if was_garnished:
		meatball.garnish()
	if was_salted:
		meatball.salt()
	
	connect_meatball(meatball)

func connect_meatball(meatball):
	curMeatball = meatball
	curMeatball.connect("death", $".", "_on_meatball_death")
	curMeatball.connect("new_checkpoint", $".", "_on_meatball_disconnect")

func _on_meatball_disconnect():
	curMeatball.disconnect("death", $".", "_on_meatball_death")
	curMeatball.disconnect("new_checkpoint", $".", "_on_meatball_disconnect")
	curMeatball = null
	cameraTransform = null
	$Sprite.frame = 1
