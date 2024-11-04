extends Node2D

@export var enemy_scenes: Array[PackedScene] = []
var spawn_pos := Vector2(1000, 500)
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_basic_enemy_button_down() -> void:
	var enemy1 = enemy_scenes[0].instantiate()
	enemy1.position = spawn_pos
	#find random target player
	var player_list = get_tree().get_nodes_in_group("player")
	enemy1.target = player_list[rng.randi_range(0, player_list.size()-1)]
	add_child(enemy1)


func _on_spawn_fast_enemy_button_down() -> void:
	var enemy1 = enemy_scenes[1].instantiate()
	enemy1.position = spawn_pos
	#find random target player
	var player_list = get_tree().get_nodes_in_group("player")
	enemy1.target = player_list[rng.randi_range(0, player_list.size()-1)]
	add_child(enemy1)


func _on_spawn_ranged_enemy_button_down() -> void:
	var enemy1 = enemy_scenes[2].instantiate()
	enemy1.position = spawn_pos
	#find random target player
	var player_list = get_tree().get_nodes_in_group("player")
	enemy1.target = player_list[rng.randi_range(0, player_list.size()-1)]
	add_child(enemy1)
