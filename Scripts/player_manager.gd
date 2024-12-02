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
	$CharBox/CharSmile.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	player_num = 1
	Global_Variables.player1 = player_scene.instantiate()
	Global_Variables.player2 = player_scene.instantiate()
	AudioManager.play_audio(SoundEffects.sound_effect_name.BUTTON)
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_play_pressed() -> void:
	#player1.get_parent().remove_child(player1)
	#player2.get_parent().remove_child(player2)
	Global_Variables.player1 = player1
	Global_Variables.player2 = player2
	player_num = 1
	get_tree().change_scene_to_file("res://Scenes/level.tscn")
		
		
#template function to shorten the script
func select_player(color, speed, scale, sprite, description):
	#player1 vs player2 things
	if is_instance_valid(player1) == false: #check for if players have been "freed" (they died)
		player1 = player_scene.instantiate()
		player2 = player_scene.instantiate()
	var current_player
	if player_num == 1:
		current_player = player1
		current_player.position = spawn_pos
		current_player.controls = load("res://Scripts/player1_controls.tres")
		$CharacterBox/Player1Box/Player1Texture.texture = sprite
		$CharacterBox/Player1Box/Player1Texture.modulate = color
		$CharacterBox/Player1Box/Player1Description.text = description
	else:
		current_player = player2
		current_player.position = Vector2(spawn_pos.x+300, spawn_pos.y)
		current_player.controls = load("res://Scripts/player2_controls.tres")
		$CharacterBox/Player2Box/Player2Texture.texture = sprite
		$CharacterBox/Player2Box/Player2Texture.modulate = color
		$CharacterBox/Player2Box/Player2Description.text = description
		
	#player type things
	current_player.Pcolor = color
	current_player.modulate = current_player.Pcolor
	current_player.speed = speed
	current_player.scale = Vector2(scale, scale)
	current_player.get_node("Sprite2D").texture = sprite
	
	AudioManager.play_audio(SoundEffects.sound_effect_name.BUTTON)
	
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
		#player1.queue_free()
		player1 = player_scene.instantiate()
		$CharacterBox/Player1Box/Player1Texture.texture = preload("res://Assets/Art/shapes/circle.png")
		$CharacterBox/Player1Box/Player1Texture.modulate = Color(0.2,0.2,0.2)
		$CharacterBox/Player1Box/Player1Description.text = "Choose Player 1"
	else:
		#player2.queue_free()
		player2 = player_scene.instantiate()
		$CharacterBox/Player2Box/Player2Texture.texture = preload("res://Assets/Art/shapes/circle.png")
		$CharacterBox/Player2Box/Player2Texture.modulate = Color(0.2,0.2,0.2)
		$CharacterBox/Player2Box/Player2Description.text = "Choose Player 2"

	AudioManager.play_audio(SoundEffects.sound_effect_name.BUTTON)
	
	if reset_flag == true:
		player_num = 1
		reset_flag = false
		
	button_disabler()


func button_disabler():
	for i in [$CharBox/CharSmile, $CharBox/CharBlast, $CharBox/CharLightning, $CharBox/CharLucky, $CharBox/CharFlower, $CharBox/CharOccult, $CharBox/CharNuclear, $CharBox/CharIcy]:
		if player_num == 3:
			if i.button_pressed == false:
				i.disabled = true
				$Play.disabled = false
		else:
			if i.disabled == true:
				i.disabled = false
				$Play.disabled = true


func _on_char_smile_toggled(toggled_on: bool) -> void:
	var description = "hes just a guy, dont mind him"
	if toggled_on == true:
		select_player(Color8(255,0,58,255), 500, 1, preload("res://Assets/Art/shapes/smile.png"), description)
	else:
		deselect_player(Color8(255,0,58,255))
		
func _on_char_blast_toggled(toggled_on: bool) -> void:
	var description = "big aoe attacks"
	if toggled_on == true:
		select_player(Color8(255,90,0,255), 500, 1, preload("res://Assets/Art/shapes/explosion.png"), description)
	else:
		deselect_player(Color8(255,90,0,255))
		
func _on_char_lightning_toggled(toggled_on: bool) -> void:
	var description = "richote i guess? is that how you spell ricoche? ricochet?"
	if toggled_on == true:
		select_player(Color8(255,252,18,255), 500, 1, preload("res://Assets/Art/shapes/lightning.png"), description)
	else:
		deselect_player(Color8(255,252,18,255))
		
func _on_char_lucky_toggled(toggled_on: bool) -> void:
	var description = "gambling or something? crits? dunno"
	if toggled_on == true:
		select_player(Color8(0,255,136,255), 500, 1, preload("res://Assets/Art/shapes/clover.png"), description)
	else:
		deselect_player(Color8(0,255,136,255))

func _on_char_flower_toggled(toggled_on: bool) -> void:
	var description = "life drain? big tendrils for attacks? spore mines? maybe bullets that rotate around you?"
	if toggled_on == true:
		select_player(Color8(252,0,193,255), 500, 1, preload("res://Assets/Art/shapes/flower.png"), description)
	else:
		deselect_player(Color8(252,0,193,255))

func _on_char_occult_toggled(toggled_on: bool) -> void:
	var description = "multishot. definitely multishot"
	if toggled_on == true:
		select_player(Color8(153,0,255,255), 500, 1, preload("res://Assets/Art/shapes/wiggles.png"), description)
	else:
		deselect_player(Color8(153,0,255,255))

func _on_char_nuclear_toggled(toggled_on: bool) -> void:
	var description = "im not sure, could be persistant low range radiation damage"
	if toggled_on == true:
		select_player(Color8(0,9,255,255), 500, 1, preload("res://Assets/Art/shapes/radioactive.png"), description)
	else:
		deselect_player(Color8(0,9,255,255))

func _on_char_icy_toggled(toggled_on: bool) -> void:
	var description = "freezing or something"
	if toggled_on == true:
		select_player(Color8(0,202,252,255), 500, 1, preload("res://Assets/Art/shapes/snowflake.png"), description)
	else:
		deselect_player(Color8(0,202,252,255))
		
