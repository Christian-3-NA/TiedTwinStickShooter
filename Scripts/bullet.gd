extends Area2D

var velocity = Vector2(1, 0)
var speed = 300
var target_group = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group(target_group):
		area.health -= 1
		self.queue_free()
