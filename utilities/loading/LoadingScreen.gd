extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	ChangeScene.goto_scene("res://launcher/launcher.tscn", self, false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
