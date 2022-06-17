extends Node

# The URL we will connect to
@export var SOCKET_URL = "ws://localhost:4545"
var hehe:int = 5

# Our WebSocketClient instance
var _client = WebSocketClient.new()

func _ready():
	# Connect base signals to get notified of connection open, close, and errors.
	_client.connection_closed.connect(_on_connection_closed)
	_client.connection_error.connect(_on_connection_closed)
	_client.connection_established.connect(_on_connected)
	# This signal is emitted when not using the Multiplayer API every time
	# a full packet is received.
	# Alternatively, you could check get_peer(1).get_available_packets() in a loop.
	_client.data_received.connect(_on_data)
	
	# Initiate connection to the given URL.
	var err = _client.connect_to_url(SOCKET_URL, ["lws-mirror-protocol"])
	if err != OK:
		print("Unable to connect")
		set_process(false)

	

func _process(_delta):
	# Call this in _process or _physics_process. Data transfer, and signals
	# emission will only happen when calling this function.
	_client.poll()

func _on_connection_closed(was_clean = false):
	print("Closed, clean : ", was_clean)
	set_process(false)

func _on_connected(proto = ""):
	print("Connected with protocole : ", proto)

func _on_data():
	# Print the received packet, you MUST always use get_peer(1).get_packet
	# to receive data from server, and not get_packet directly when not
	# using the MultiplayerAPI.
	print("Got data from server : ", _client.get_peer(1).get_packet().get_string_from_utf8())
	_send()

func _send():
	# You MUST always use get_peer(1).put_packet to send data to server,
	# and not put_packet directly when not using the MultiplayerAPI.
	var test:String = "Test Packet"
	_client.get_peer(1).put_packet(test.to_utf8_buffer())
