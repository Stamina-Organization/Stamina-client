extends Node

# The URL we will connect to
@export var SOCKET_URL = "ws://83.150.217.31:2025"
# Our WebSocketClient instance
var client = WebSocketClient.new()
var statut_connexion: bool

func _ready():
	connexion()

func _process(_delta):
	# Call this in _process or _physics_process. Data transfer, and signals
	# emission will only happen when calling this function.
	client.poll()

func _on_connection_closed(was_clean = false):
	print("Closed, clean : ", was_clean)
	set_process(false)

func _on_connected(proto = ""):
	print("Connected with protocole : ", proto)
	_set_statut(true)

func _on_data():
	# Print the received packet, you MUST always use get_peer(1).get_packet
	# to receive data from server, and not get_packet directly when not
	# using the MultiplayerAPI.
	print("Got data from server : ", client.get_peer(1).get_packet().get_string_from_utf8())
	HandlerToServer.send_data(client)

func _send():
	# You MUST always use get_peer(1).put_packet to send data to server,
	# and not put_packet directly when not using the MultiplayerAPI.
	var test:Dictionary = {"test":"test1"}
	var hehe = str(test)
	client.get_peer(1).put_packet(hehe.to_utf8_buffer())

func connexion():
	# Connect base signals to get notified of connection open, close, and errors.
	client.connection_closed.connect(_on_connection_closed)
	client.connection_error.connect(_on_connection_closed)
	client.connection_established.connect(_on_connected)
	# This signal is emitted when not using the Multiplayer API every time
	# a full packet is received.
	# Alternatively, you could check get_peer(1).get_available_packets() in a loop.
	client.data_received.connect(_on_data)
	
	# Initiate connection to the given URL.
	var err = client.connect_to_url(SOCKET_URL, ["lws-mirror-protocol"])
	if err != OK:
		print("Unable to connect")
		set_process(false)
		_set_statut(false)

func _set_statut(statut: bool):
	statut_connexion = statut

func get_statut():
	return statut_connexion
