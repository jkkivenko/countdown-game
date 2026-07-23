extends Node

var time_left := 12.0
var last_whole_second := -1
var audio_stream_player : AudioStreamPlayer
var has_timed_out = false

signal timeout

func _ready() -> void:
	audio_stream_player = AudioStreamPlayer.new()
	add_child(audio_stream_player)
	audio_stream_player.stream = preload("res://Assets/dwoop.mp3")

func _process(delta: float) -> void:
	if time_left > 0:
		if time_left <= 10.0 and floor(time_left) != last_whole_second:
			audio_stream_player.play()
			last_whole_second = int(floor(time_left))
		if time_left > 5.0:
			time_left -= delta
		else:
			time_left -= delta * lerp(1.0, 0.75, (5 - time_left) / 5)
	elif not has_timed_out:
		timeout.emit()
		has_timed_out = true
		audio_stream_player.pitch_scale = 2
		audio_stream_player.play()
