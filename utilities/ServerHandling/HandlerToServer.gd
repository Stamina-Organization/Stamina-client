extends Node

var data_to_send:Dictionary = {
	"client_type":"client",
	"roomID":{
		"playerID":{
			"BossPosition": true,
			"mobs1Position": false,
			"mobs2Position": false,
			"Player": {
				"Position" : "",
				"Rotation" : ""
			},
			"KeysUsed": {
				"Forward": false,
				"Backward": false,
				"Left": false,
				"Right": false,
				"Jump": false,
				"Spell1": false,
				"Spell2": false,
				"Spell3": false,
				"Spell4": false,
				"RightClick": false,
				"LeftClick": false,
				"Crouch": false
			},
			"Spells":{
				"Spell1":"FireBall"
			}
			
		}
	} 
}

func send_data(client):
	var data = str(data_to_send)
	client.get_peer(1).put_packet(data.to_utf8_buffer())

func set_data_player(position: Vector3):
	data_to_send["roomID"]["playerID"]["Player"]["Position"] = str(position)

func set_data_entity(position: Vector3):
	pass

func send_connexion_info(client):
	var connexion_data = {
		"connexion":"account",
		"data": SaveFile.game_data
	}
	client.get_peer(1).put_packet(str(connexion_data).to_utf8_buffer())
