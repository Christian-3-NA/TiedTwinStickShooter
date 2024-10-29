extends Area2D

@export var controls: Resource = null
@export var speed = 400
@export var Pcolor = Color (0,0,0,1)
@export var health = 3
@export var damage = 1
@export var size = 2 #temp
#Default player values
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed(controls.move_right):
		velocity.x += 1
	if Input.is_action_pressed(controls.move_left):
		velocity.x -= 1
	if Input.is_action_pressed(controls.move_down):
		velocity.y += 1
	if Input.is_action_pressed(controls.move_up):
		velocity.y -= 1	
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	
