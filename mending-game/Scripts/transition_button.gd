extends TextureButton
@export var changeScene : String
@export var textString : String

func _ready() -> void:
	$Label.text = textString
	
func _on_pressed() -> void:
	AudioManager.audio_stream_02.play()
	$Timer.start()


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file(changeScene)
