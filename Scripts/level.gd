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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_active:
		distance = sqrt(pow(player1.position.x - player2.position.x, 2) + pow(player1.position.y - player2.position.y, 2))
		$Camera2D.position.x = (.5 * player1.position.x + .5 * player2.position.x)
		$Camera2D.position.y = (.5 * player1.position.y + .5 * player2.position.y)
		
		#keeps the player inside the play area
		var play_area = $PlayArea/CollisionShape2D
		var play_area_size = play_area.get_shape().size
		player1.position = player1.position.clamp(play_area.position - play_area_size/2, play_area.position + play_area_size/2)
		player2.position = player2.position.clamp(play_area.position - play_area_size/2, play_area.position + play_area_size/2)

		#makes the camera stop when it sees the edge of the map
		var view_size = get_viewport().get_visible_rect().size
		$Camera2D.position = $Camera2D.position.clamp((play_area.position - play_area_size/2) + view_size, (play_area.position + play_area_size/2) - view_size)

func _on_start_pressed() -> void:
	#loads players into level
	player1.position = spawn_pos
	player1.controls = load("res://Scripts/player1_controls.tres")
	player2.position = Vector2(spawn_pos.x+300, spawn_pos.y)
	player2.controls = load("res://Scripts/player2_controls.tres")
	add_child(player1)
	add_child(player2)
	
	#starts the enemy manager
	
	#change variables necessary for game start
	$Start.visible = false
	game_active = true
	$Camera2D.zoom.x = camera_zoom
	$Camera2D.zoom.y = camera_zoom
	
