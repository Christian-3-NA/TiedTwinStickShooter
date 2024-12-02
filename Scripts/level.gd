extends Node2D


var player_scene = load("res://Scenes/player.tscn")
var enemy_manager_scene = load("res://Scenes/enemy_manager.tscn")
var spawn_pos := Vector2(600, 750)
var player_num = int (1)
var player1 = Global_Variables.player1
var player2 = Global_Variables.player2
# Vector2(0, 0)
var game_active = false
var distance
var camera_zoom = .4
#players cant get more than max_rope_length away from each other, and start acting one ach other at pulling_length
#var max_rope_length = 500
#var pulling_length = 400

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#skips the start button screen
	$EnemyManager.parent_camera_zoom = camera_zoom
	_on_start_pressed()
	$EnemyManager._on_start_pressed()
	
	#move the hud to scale with zoom
	$Camera2D/PlayerHud.position = Vector2($Camera2D/PlayerHud.position.x/camera_zoom, $Camera2D/PlayerHud.position.y/camera_zoom)
	
	#adds player healths to global health (and prevents invincibility on spawn in)
	Global_Variables.player_health = player1.health + player2.health
	player1.prev_health = Global_Variables.player_health
	player2.prev_health = Global_Variables.player_health
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_active:
		#distance calculation and camera movement
		distance = sqrt(pow(player1.position.x - player2.position.x, 2) + pow(player1.position.y - player2.position.y, 2))
		$Camera2D.position.x = ((player1.position.x + player2.position.x) / 2)
		$Camera2D.position.y = ((player1.position.y + player2.position.y) / 2)
		
		#keeps the player inside the play area
		var play_area = $PlayArea/CollisionShape2D
		var play_area_size = play_area.get_shape().size
		player1.position = player1.position.clamp(play_area.position - play_area_size/2, play_area.position + play_area_size/2)
		player2.position = player2.position.clamp(play_area.position - play_area_size/2, play_area.position + play_area_size/2)
		
		#updates the line between the players
		queue_redraw()
		
		#give each player the others position
		player1.partner_pos = player2.position
		player2.partner_pos = player1.position
		
		#makes the camera stop when it sees the edge of the map
		var view_size = get_viewport().get_visible_rect().size
		$Camera2D.position = $Camera2D.position.clamp((play_area.position - play_area_size/2) + view_size, (play_area.position + play_area_size/2) - view_size)
		
		#update hud
		$Camera2D/PlayerHud.text = str("HEALTH: ", Global_Variables.player_health, "\nCOINS: ", Global_Variables.coinsHeld)
		
		
func _on_start_pressed() -> void:
	#loads players into level
	player1.position = spawn_pos
	player1.controls = load("res://Scripts/player1_controls.tres")
	player2.position = Vector2(spawn_pos.x+300, spawn_pos.y)
	player2.controls = load("res://Scripts/player2_controls.tres")
	add_child(player1)
	add_child(player2)
	
	#change variables necessary for game start
	$Start.visible = false
	game_active = true
	$Camera2D.zoom.x = camera_zoom
	$Camera2D.zoom.y = camera_zoom
	
func _draw():
	draw_line(player1.position, player2.position, Color(255, 255, 255, 1), 2, true)
