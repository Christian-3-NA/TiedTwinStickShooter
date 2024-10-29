extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/player_manager.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/settings.tscn")



func _on_exit_pressed() -> void:
	get_tree().quit()
