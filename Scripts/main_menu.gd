extends Control

func _ready() -> void:
	$MarginContainer/VBoxContainer/Play.grab_focus()


func _on_play_pressed() -> void:
	AudioManager.play_audio(SoundEffects.sound_effect_name.BUTTON)
	get_tree().change_scene_to_file("res://Scenes/player_manager.tscn")


func _on_options_pressed() -> void:
	AudioManager.play_audio(SoundEffects.sound_effect_name.BUTTON)
	get_tree().change_scene_to_file("res://Scenes/settings.tscn")



func _on_exit_pressed() -> void:
	AudioManager.play_audio(SoundEffects.sound_effect_name.BUTTON)
	get_tree().quit()
