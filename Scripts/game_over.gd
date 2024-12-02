extends Control

var game_over_audio_check = false # ensures game_over audio only plays once

func _ready() -> void:
	Signals.game_over.connect(_on_game_over)

func _on_quit_pressed() -> void:
	$"..".visible = false # set CanvasLayer root to be hidden
	get_tree().paused = false # lets buttons be pressed again
	AudioManager.play_audio(SoundEffects.sound_effect_name.BUTTON)
	get_tree().change_scene_to_file("res://Scenes/menu_manager.tscn") # go back to main screen


func _on_game_over():
	if(game_over_audio_check == false):
		AudioManager.play_audio(SoundEffects.sound_effect_name.GAME_OVER)
	game_over_audio_check = true
	get_tree().paused = true  # not sure if we want this 
	$"..".visible = true #set CanvasLayer root to be visible
	$quit.grab_focus()
