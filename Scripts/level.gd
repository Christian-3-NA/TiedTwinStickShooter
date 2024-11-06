extends Node2D
var player_scene = load("res://Scenes/player.tscn")
var spawn_pos := Vector2(500, 250)
var player_num = int (1)
var player1 = Global_Variables.player1
var player2 = Global_Variables.player2
# Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	player1.position = spawn_pos
	player1.controls = load("res://Scripts/player1_controls.tres")
	player2.position = Vector2(spawn_pos.x+300, spawn_pos.y)
	player2.controls = load("res://Scripts/player2_controls.tres")
	add_child(player1)
	add_child(player2)
	$Start.visible = false
	
