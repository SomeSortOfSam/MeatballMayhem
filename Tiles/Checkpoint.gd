extends Area2D

onready var Meatball = preload("res://Meatball/Meatball.tscn")

var curMeatball
var cameraTransform

func _on_Checkpoint_body_entered(body):
	#disconect previous checkpoint
	body.set_new_checkpoint()
	
	body.connect("death", $".", "_on_meatball_death")
	body.connect("new_checkpoint", $".", "_on_meatball_disconnect")
	curMeatball = body
	cameraTransform = body.get_node("RemoteTransform2D")
	
func _on_meatball_death():
	var meatball = Meatball.instance()
	get_tree().current_scene.call_deferred("add_child",meatball)
	meatball.global_position = global_position
	curMeatball.remove_child(cameraTransform)
	meatball.add_child(cameraTransform)
	if curMeatball.cooked:
		meatball.cook()
	curMeatball.queue_free()
	curMeatball = meatball

func _on_meatball_disconnect():
	curMeatball.disconnect("death", $".", "_on_meatball_death")
	curMeatball.disconnect("new_checkpoint", $".", "_on_meatball_disconnect")
