extends Control

func _ready() -> void:
	Signals.game_over.connect(_on_game_over)

func _on_quit_pressed() -> void:
	$"..".visible = false # set CanvasLayer root to be hidden
	get_tree().paused = false # lets buttons be pressed again
	get_tree().change_scene_to_file("res://Scenes/menu_manager.tscn") # go back to main screen


func _on_game_over():
	get_tree().paused = true  # not sure if we want this 
	$"..".visible = true #set CanvasLayer root to be visible
	$quit.grab_focus()
