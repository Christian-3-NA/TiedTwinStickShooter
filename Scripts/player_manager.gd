extends Node2D

var player_scene = load("res://Scenes/player.tscn")
var spawn_pos := Vector2(500, 250)
var player_num = int (1)
# Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# temporary function for spawning player nodes
func _on_temp_spawn_player_button_down() -> void:
	if player_num == 1:
		var player1 = player_scene.instantiate()
		player1.position = spawn_pos
		player1.controls = load("res://Scripts/player1_controls.tres")
		add_child(player1)
		player_num += 1
	elif player_num == 2:
		var player2 = player_scene.instantiate()
		player2.position = Vector2(spawn_pos.x+300, spawn_pos.y)
		player2.controls = load("res://Scripts/player2_controls.tres")
		add_child(player2)
		player_num += 3


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_zoomie_pressed() -> void:
	if player_num == 1:
		var player1 = player_scene.instantiate()
		player1.Pcolor = Color(0.2, 0, 1 , 1)
		player1.modulate = player1.Pcolor
		player1.position = spawn_pos
		player1.controls = load("res://Scripts/player1_controls.tres")
		player1.speed = 1000
		add_child(player1)
		player_num += 1
	elif player_num == 2:
		var player2 = player_scene.instantiate()
		player2.Pcolor = Color(0.2, 0, 1 , 1)
		player2.modulate = player2.Pcolor
		player2.position = Vector2(spawn_pos.x+300, spawn_pos.y)
		player2.controls = load("res://Scripts/player2_controls.tres")
		player2.speed = 1000
		add_child(player2)
		player_num += 3



func _on_chunky_pressed() -> void:
	if player_num == 1:
		var player1 = player_scene.instantiate()
		player1.Pcolor = Color(0, .5, .5 , 1)
		player1.scale = Vector2(2,2)
		player1.modulate = player1.Pcolor
		player1.position = spawn_pos
		player1.controls = load("res://Scripts/player1_controls.tres")
		player1.speed = 500
		add_child(player1)
		player_num += 1
	elif player_num == 2:
		var player2 = player_scene.instantiate()
		player2.Pcolor = Color(0, 0.5, 0.5 , 1)
		player2.scale = Vector2(2,2) 
		player2.modulate = player2.Pcolor
		player2.position = Vector2(spawn_pos.x+300, spawn_pos.y)
		player2.controls = load("res://Scripts/player2_controls.tres")
		player2.speed = 500
		add_child(player2)
		player_num += 3


func _on_snail_pressed() -> void:
	if player_num == 1:
		var player1 = player_scene.instantiate()
		player1.Pcolor = Color(0, 1, 0 , 1)
		player1.modulate = player1.Pcolor
		player1.position = spawn_pos
		player1.controls = load("res://Scripts/player1_controls.tres")
		player1.speed = 100
		add_child(player1)
		player_num += 1
	elif player_num == 2:
		var player2 = player_scene.instantiate()
		player2.Pcolor = Color(0, 1, 0 , 1) 
		player2.modulate = player2.Pcolor
		player2.position = Vector2(spawn_pos.x+300, spawn_pos.y)
		player2.controls = load("res://Scripts/player2_controls.tres")
		player2.speed = 100
		add_child(player2)
		player_num += 3



func _on_tipsy_pressed() -> void:
	if player_num == 1:
		var player1 = player_scene.instantiate()
		player1.Pcolor = Color(1, 0, 1 , 1)
		player1.modulate = player1.Pcolor
		player1.position = spawn_pos
		player1.controls = load("res://Scripts/player1_controls.tres")
		player1.speed = 759
		add_child(player1)
		player_num += 1
	elif player_num == 2:
		var player2 = player_scene.instantiate()
		player2.Pcolor = Color(1, 0, 1 , 1) 
		player2.modulate = player2.Pcolor
		player2.position = Vector2(spawn_pos.x+300, spawn_pos.y)
		player2.controls = load("res://Scripts/player2_controls.tres")
		player2.speed = 759
		add_child(player2)
		player_num += 3
