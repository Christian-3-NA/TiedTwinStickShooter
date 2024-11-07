extends Area2D

var velocity = Vector2(0, 0)
@export var health = 3
@export var speed = 200
@export var budget_cost = 1
var target = Area2D
var enemies_push_force = 8

var coin_scene = load("res://Scenes/coin.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health <= 0:
		die()
	
	velocity = target.position - self.position
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	enemy_personal_space()
	
	position += velocity * delta

func enemy_personal_space():
	for area in get_overlapping_areas():
		if area.is_in_group("enemy"):
			self.velocity -= position.direction_to(area.position) * enemies_push_force

func die():
	var coin = coin_scene.instantiate()    #drop coin and add it as a child to a coin group
	coin.global_position = self.global_position
	get_tree().get_root().get_node("Level/Coins").add_child(coin)
	self.queue_free()
