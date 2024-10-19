extends Node2D

var player_scene = load("res://Scenes/player.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# temporary function for spawning player nodes
func _on_temp_spawn_player_button_down() -> void:
	var player1 = player_scene.instantiate()
	add_child(player1)
