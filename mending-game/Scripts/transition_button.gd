extends TextureButton
@export var changeScene : String
@export var textString : String

func _ready() -> void:
	$Label.text = textString
func _on_pressed() -> void:
	get_tree().change_scene_to_file(changeScene)
