extends Node2D

@export var enemy_scenes: Array[PackedScene] = []
var enemy_index = []
var spawn_pos := Vector2(1000, 500)
var rng = RandomNumberGenerator.new()
var avg_spawn_timer = 3
var starting_budget = 3
var budget_scaling = .5
var num_waves = 0
var parent_camera_zoom


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$WaveTimer.wait_time = avg_spawn_timer
	#unpacks enemy scene to fill the enemy_index [0=index_num,1=budget_cost]
	var index_num = 0
	for i in enemy_scenes:
		var temp_enemy = i.instantiate()
		enemy_index.append([index_num, temp_enemy.budget_cost])
		index_num += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_basic_enemy_button_down() -> void:
	var player_list = get_tree().get_nodes_in_group("player")
	instantiate_enemy(0, spawn_pos, player_list[rng.randi_range(0, player_list.size()-1)])
func _on_spawn_fast_enemy_button_down() -> void:
	var player_list = get_tree().get_nodes_in_group("player")
	instantiate_enemy(1, spawn_pos, player_list[rng.randi_range(0, player_list.size()-1)])
func _on_spawn_ranged_enemy_button_down() -> void:
	var player_list = get_tree().get_nodes_in_group("player")
	instantiate_enemy(2, spawn_pos, player_list[rng.randi_range(0, player_list.size()-1)])


func instantiate_enemy(index, pos, target):
	var player_list = get_tree().get_nodes_in_group("player")
	var enemy1 = enemy_scenes[index].instantiate()
	enemy1.position = pos
	enemy1.target = target
	#enemies have target of opposite color
	if target == player_list[0]:
		enemy1.modulate = Color(player_list[1].Pcolor)
		enemy1.Ecolor = Color(player_list[1].Pcolor)
	if target == player_list[1]:
		enemy1.modulate = Color(player_list[0].Pcolor)
		enemy1.Ecolor = Color(player_list[0].Pcolor)
	add_child(enemy1)


func _on_start_pressed() -> void:
	$WaveTimer.start()


func _on_wave_timer_timeout() -> void:
	#spend the budget on enemies to spawn
	var player_list = get_tree().get_nodes_in_group("player")
	var current_budget = floor(starting_budget + budget_scaling * num_waves)
	while current_budget > 0:
		var temp = enemy_index.pick_random()
		if temp[1] <= current_budget:
			instantiate_enemy(temp[0], random_spawn_pos(), player_list.pick_random())
			current_budget -= temp[1]
	num_waves += 1


func random_spawn_pos():
	#viewport variables
	var view_pos = get_viewport().get_camera_2d().position
	var view_height = get_viewport().get_visible_rect().size.y/parent_camera_zoom/2
	var view_width = get_viewport().get_visible_rect().size.x/parent_camera_zoom/2
	
	#random position along the edge
	var rng_spawn_pos = Vector2.ZERO
	match rng.randi_range(0,3):
		0: #top edge
			rng_spawn_pos = Vector2(rng.randi_range(view_pos.x - view_width, view_pos.x + view_width), view_pos.y - view_height - 100)
		1: #right edge
			rng_spawn_pos = Vector2(view_pos.x + view_width + 100, rng.randi_range(view_pos.y - view_height, view_pos.y + view_height))
		2: #bottom edge
			rng_spawn_pos = Vector2(rng.randi_range(view_pos.x - view_width, view_pos.x + view_width), view_pos.y + view_height + 100)
		3: #left edge
			rng_spawn_pos = Vector2(view_pos.x - view_width - 100, rng.randi_range(view_pos.y - view_height, view_pos.y + view_height))
	
	return rng_spawn_pos
