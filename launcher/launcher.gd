extends Control


@onready var connexion_true = preload("res://assets/icons/connexion_true.png")
@onready var connexion_false = preload("res://assets/icons/connexion_false.png")
@onready var statuts = $Background/content/ConnexionState

@onready var settings_windows = $Background/Settings
@onready var credits_windows = $Background/Credits
@export var show_settings: bool = false
@export var show_credits: bool = false

func _ready():
	pass

func _on_SettingsButton_pressed():
	if show_settings == false:
		settings_windows.show()
		show_settings = true
	elif show_settings == true:
		settings_windows.hide()
		show_settings = false

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		settings_windows.hide()
		credits_windows.hide()
	if Connexion.get_statut() == true:
		statuts.icon = connexion_true
		statuts.disabled = true
	else:
		statuts.icon = connexion_false
		statuts.disabled = false

func _on_credits_button_pressed():
	if show_credits == false:
		credits_windows.show()
		show_credits = true
	elif show_credits == true:
		credits_windows.hide()
		show_credits = false


func _on_connexion_state_pressed():
	Connexion.connexion()
