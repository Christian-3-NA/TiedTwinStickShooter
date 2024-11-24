extends Area2D

var Ccolor = Color(1,1,1,1)
var move_to = Node
var velocity = Vector2.ZERO
var speed = 0


func _on_area_entered(area: Area2D) -> void: # Grab coin when player enters hitbox (Might be better to do this on players logic)
	if area.is_in_group("player"):
		if area.Pcolor == self.Ccolor:
			Signals.coin_collected.emit()
			queue_free()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if move_to == Global_Variables.player1 or move_to == Global_Variables.player2:
		self.velocity += position.direction_to(move_to.position)
	
	if velocity.length() > 0:
		velocity = velocity.normalized()
		
	position += velocity * delta * speed
	speed += 10
	if speed > 1000:
		speed = 1000
