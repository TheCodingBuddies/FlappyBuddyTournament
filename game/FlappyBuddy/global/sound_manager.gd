extends Node

var stream_players: Dictionary = {}
var sound_muted = false

func play(stream: AudioStream, on_finish: Callable = func():):
	if not stream_players.has(stream.resource_path):
		stream_players[stream.resource_path] = _create_new_player(stream)
		
	var stream_player = stream_players.get(stream.resource_path)
	stream_player.play()
	stream_player.finished.connect(on_finish, CONNECT_ONE_SHOT)	
	
func _create_new_player(stream: AudioStream) -> AudioStreamPlayer:
	var new_stream_player = AudioStreamPlayer.new()
	new_stream_player.bus = "Master"
	new_stream_player.max_polyphony = 50
	new_stream_player.stream = stream
	add_child(new_stream_player)
	return new_stream_player
	
func stop_all() -> void:
	for key in stream_players.keys():
		stream_players.get(key).stop()
		
func toggle_mute() -> void:
	sound_muted = not sound_muted
	set_mute(sound_muted)
	
func set_mute(on: bool) -> void:
	var bus_idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(bus_idx, on)
	
func set_playback_speed(value: float) -> void:
	AudioServer.playback_speed_scale = value
