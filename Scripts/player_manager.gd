extends Node2D

var player_scene = load("res://Scenes/player.tscn")
var spawn_pos := Vector2(500, 250)
# Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# temporary function for spawning player nodes
func _on_temp_spawn_player_button_down() -> void:
	var player1 = player_scene.instantiate()
	player1.position = spawn_pos
	player1.controls = load("res://Scripts/player1_controls.tres")
	add_child(player1)
	var player2 = player_scene.instantiate()
	player2.position = Vector2(spawn_pos.x+300, spawn_pos.y)
	player2.controls = load("res://Scripts/player2_controls.tres")
	add_child(player2)
