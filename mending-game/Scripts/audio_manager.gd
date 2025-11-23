extends Node

const mute_db := -80.0 # To mute the audio player
const default_music_db := 0.0 # This is for normal volume
#const fade_time := 2.0 # The time it takes to fade in/out in seconds

var current_music_player : AudioStreamPlayer # the current player

@onready var audio_stream_01 : AudioStreamPlayer = $MusicPlayer
@onready var audio_stream_02 : AudioStreamPlayer = $SFXPlayer

func _ready() -> void:
	current_music_player = audio_stream_01
	audio_stream_01.autoplay
	audio_stream_01.pitch_scale = 1
	
func music_setPitch(pitch:float):
	if pitch >= 2.5:
		audio_stream_01.pitch_scale = 2.5
	else:
		audio_stream_01.pitch_scale = pitch
