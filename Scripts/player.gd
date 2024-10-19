extends Area2D

@export var speed = 400

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("player_1_right"):
		velocity.x += 1
	if Input.is_action_pressed("player_1_left"):
		velocity.x -= 1
	if Input.is_action_pressed("player_1_down"):
		velocity.y += 1
	if Input.is_action_pressed("player_1_up"):
		velocity.y -= 1	
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	
