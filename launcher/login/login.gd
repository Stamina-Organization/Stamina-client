extends Control

@onready var psw_bracket = $Background/Password
@onready var username_bracket = $Background/Email
@onready var login_window = $"."
@onready var BadData = $Background/BadData
@onready var BadPassword = $Background/BadPassword
@onready var save_file = SaveFile.game_data
var psw:String
var email:String

func _ready():
	pass

func login(email:String, password:String):

	# Create an HTTP request node and connect its completion signal.
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)

	# Perform a POST request. The URL below returns JSON as of writing.
	# Note: Don't make simultaneous requests using a single HTTPRequest node.
	# The snippet below is provided for reference only.
	var truc = "email=%s&psw=%s"
	var body = truc % [email, password]
	var headers = ["Content-Type: application/x-www-form-urlencoded"]
	var error = http_request.request("http://node1.adky.net:3034/game/login/", headers, true, HTTPClient.METHOD_POST, body)
	#print(body)
	if error != OK:
		push_error("An error occurred in the HTTP request.")


# Called when the HTTP request is completed.
func _http_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	var error = json.parse(body.get_string_from_utf8())
	#print(body)
	var response = json.get_data()
	#print("error : ", error)
	#Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	#print(response)
	if response["code"] == 200:
		save_file["account"]["email"] = response["data"]["email"]
		save_file["account"]["username"] = response["data"]["username"]
		save_file["account"]["createdAt"] = response["data"]["createdAt"]
		save_file["account"]["tag"] = response["data"]["tag"]
		save_file["account"]["permissions"] = response["data"]["permissions"]
		save_file["connected"] = true
		SaveFile.save_data()
		login_window.hide()
	elif response["code"] == 404:
		BadData.show()
		BadPassword.show()


func _on_email_text_changed(new_text):
	email = new_text
	#print(email)


func _on_password_text_changed(new_text):
	psw = new_text
	#print(psw)


func _on_continue_button_pressed():
	login(email,psw)
