extends Node

var data_to_send:Dictionary = {}

func send_data(client):
	var test = str(data_to_send)
	client.get_peer(1).put_packet(test.to_utf8_buffer())

func set_data_player(position: Vector3):
	data_to_send = {
		"method": "ValidateUserPosition",
		"data": {
			"position": str(position)
		}
	}

func set_data_entity(position: Vector3):
	pass
