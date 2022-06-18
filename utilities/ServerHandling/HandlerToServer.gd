extends Node

var data_to_send:Dictionary= {"test":"test"}

func send_data(client):
	var test = str(data_to_send)
	print(test)
	client.get_peer(1).put_packet(test.to_utf8_buffer())

func set_data():
	pass
