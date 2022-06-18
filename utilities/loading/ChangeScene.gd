extends Node

@onready var loading_screen = preload("res://utilities/loading/LoadingScreen.tscn").instantiate()

var progress = []
var scene_load_status = 0

var real_path = ""
@onready var loading_bar: ProgressBar
@onready var error: RichTextLabel
var curr
var screen: bool
@export var max_load_time = 10000

func _ready():
	loading_bar = loading_screen.get_node("ProgressBar")
	error = loading_screen.get_node("Error")

func _process(_delta):
	
	scene_load_status = ResourceLoader.load_threaded_get_status(real_path, progress)
	loading_bar.value = progress[0] * 100
	
	if scene_load_status == ResourceLoader.THREAD_LOAD_FAILED:
		error.show()
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		print("Chargement terminé")
		get_tree().change_scene_to(ResourceLoader.load_threaded_get(real_path))
		if screen == true:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		elif screen == false:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)



func goto_scene(path, current_scene, windows_mode: bool):
	get_tree().change_scene("res://utilities/loading/LoadingScreen.tscn")
	#add_child(loading_screen)
	screen = windows_mode
	curr = current_scene
	real_path = path
	
	print("Début du chargement...")
	ResourceLoader.load_threaded_request(real_path)


