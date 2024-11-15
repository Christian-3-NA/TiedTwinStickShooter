extends Node
var player_scene = load("res://Scenes/player.tscn")
var player1 = player_scene.instantiate()
var player2 = player_scene.instantiate()
var playerHurt = 2500
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
