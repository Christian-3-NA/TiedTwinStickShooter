extends Node2D
var player_scene = load("res://Scenes/player.tscn")
var spawn_pos := Vector2(500, 250)
var player_num = int(1)
var player1 = Global_Variables.player1
var player2 = Global_Variables.player2
var playerSafe = 250
# Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(is_instance_valid(player1))


func _on_back_pressed() -> void:
	player_num = 1
	Global_Variables.player1 = player_scene.instantiate()
	Global_Variables.player2 = player_scene.instantiate()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_play_pressed() -> void:
	player1.get_parent().remove_child(player1)
	player2.get_parent().remove_child(player2)
	Global_Variables.player1 = player1
	Global_Variables.player2 = player2
	player_num = 1
	get_tree().change_scene_to_file("res://Scenes/level.tscn")


func _on_temp_spawn_player_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		#selected_players.append(1)
		select_player(Color(.9,.9,.9,1), 400, 1)
	else:
		#selected_players.erase(1)
		deselect_player(Color(.9,.9,.9,1))
		
func _on_zoomie_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		#selected_players.append(1)
		select_player(Color(0.2,0,1,1), 1000, 1)
	else:
		deselect_player(Color(0.2,0,1,1))
		
func _on_chunky_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		select_player(Color(0,.5,.5,1), 500, 2)
	else:
		deselect_player(Color(0,.5,.5,1))
		
func _on_snail_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		select_player(Color(0,1,0,1), 200, 1)
	else:
		deselect_player(Color(0,1,0,1))
		
func _on_tipsy_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		select_player(Color(1,0,1,1), 759, 1)
	else:
		deselect_player(Color(1,0,1,1))
		
#template function to shorten the script
func select_player(color, speed, scale):
	#player1 vs player2 things
	if is_instance_valid(player1) == false: #check for if players have been "freed" (they died)
		player1 = player_scene.instantiate()
		player2 = player_scene.instantiate()
	var current_player
	if player_num == 1:
		current_player = player1
		current_player.position = spawn_pos
		current_player.controls = load("res://Scripts/player1_controls.tres")
	else:
		current_player = player2
		current_player.position = Vector2(spawn_pos.x+300, spawn_pos.y)
		current_player.controls = load("res://Scripts/player2_controls.tres")
		
	#player type things
	current_player.Pcolor = color
	current_player.modulate = current_player.Pcolor
	current_player.speed = speed
	current_player.scale = Vector2(scale, scale)
	
	add_child(current_player)
	if player2.Pcolor != Color(1,1,1,1):
		player_num = 3
	else:
		player_num += 1
		
	button_disabler()


func deselect_player(deselected_color):
	#messy if statement to handle deselecting the first player before the second
	var reset_flag = false
	if deselected_color == player1.Pcolor:
		player_num = 1
	else:
		player_num -= 1
		if player_num < 1:
			player_num = 2
			reset_flag = true
	
	if player_num == 1:
		player1.queue_free()
		player1 = player_scene.instantiate()
	else:
		player2.queue_free()
		player2 = player_scene.instantiate()

	if reset_flag == true:
		player_num = 1
		reset_flag = false
		
	button_disabler()

func button_disabler():
	for i in [$TempSpawnPlayer, $Zoomie, $Chunky, $Snail, $Tipsy]:
		if player_num == 3:
			if i.button_pressed == false:
				i.disabled = true
		else:
			if i.disabled == true:
				i.disabled = false
