extends Control

func _ready() -> void:
	Signals.game_over.connect(_on_game_over)

func _on_quit_pressed() -> void:
	$"..".visible = false # set CanvasLayer root to be hidden
	print("Help")
	get_tree().change_scene_to_file("res://Scenes/menu_manager.tscn") # go back to main screen
	#TODO: menu doesnt work after quitting back to it

func _on_game_over():
	get_tree().paused = true  # not sure if we want this 
	$"..".visible = true #set CanvasLayer root to be visible
