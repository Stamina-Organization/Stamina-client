extends Node

var data_to_send:Dictionary = {
	"method": "calc",
	"data": {
		"firstN": 1,
		"secondN": 2
	}
}

func send_data(client):
	var test = str(data_to_send)
	client.get_peer(1).put_packet(test.to_utf8_buffer())

func set_data_player(position: Vector3, input):
	pass

func set_data_entity(position: Vector3):
	pass
