extends Node

const default_name = "waiting for connection..."
var websocket: WebSocketMultiplayerPeer
var url = "ws://localhost"
var connected_bot_name = default_name
var port = 5050

func _ready() -> void:
	restart_server_on(port)
	
func restart_server_on(new_port):
	port = new_port
	if websocket:
		websocket.close()
		websocket = null
	websocket = WebSocketMultiplayerPeer.new()
	websocket.create_server(new_port)
	websocket.set_max_queued_packets(3)
	websocket.peer_connected.connect(func(peer): set_bot_name(peer))
	websocket.peer_disconnected.connect(func(peer): clean_bot_name())

func clean_bot_name():
	connected_bot_name = default_name

func get_bot_name():
	if not GameManager._is_bot or connected_bot_name == default_name:
		return "Human"
	return connected_bot_name

func set_bot_name(peer):
	var req_url = websocket.get_peer(peer).get_requested_url()
	var url_parts = Array(req_url.split("/"))
	connected_bot_name = url_parts.back()

func _physics_process(_delta: float) -> void:
	websocket.poll()
	if websocket.get_available_packet_count() > 0:
		data_received()

func data_received():
	var payload = websocket.get_packet().get_string_from_utf8()
	var parsed_payload = JSON.parse_string(payload)
	GameManager.last_bot_input = parsed_payload.fly
	
func send(data: String) -> void:
	if not has_connection():
		return
	websocket.put_packet(data.to_utf8_buffer())

func has_connection() -> bool:
	return connected_bot_name != default_name

func _notification(what: int) -> void:
	if(what == NOTIFICATION_WM_CLOSE_REQUEST):
		websocket.close()
