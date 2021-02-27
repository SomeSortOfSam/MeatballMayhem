extends Area2D

onready var Meatball = preload("res://Meatball/Meatball.tscn")

var curMeatball
var cameraTransform

var was_cooked = false

func _on_Checkpoint_body_entered(body):
	if curMeatball == null:
		#disconect previous checkpoint
		body.set_new_checkpoint()
		
		connect_meatball(body)
		was_cooked = body.cooked
		cameraTransform = body.get_node("RemoteTransform2D")

func _on_meatball_death():
	var meatball = Meatball.instance()
	get_tree().current_scene.call_deferred("add_child",meatball)
	meatball.global_position = global_position
	curMeatball.remove_child(cameraTransform)
	meatball.add_child(cameraTransform)
	if was_cooked:
		meatball.cook()
	curMeatball.queue_free()
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
	
