extends Node2D


var enemy_scene = load("res://Scenes/enemy.tscn")
var spawn_pos := Vector2(1000, 500)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_temp_spawn_enemy_button_down() -> void:
	var enemy1 = enemy_scene.instantiate()
	enemy1.position = spawn_pos
	add_child(enemy1)
