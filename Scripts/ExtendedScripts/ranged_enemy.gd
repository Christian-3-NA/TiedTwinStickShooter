extends "res://Scripts/enemy.gd"
#Inherits the die() function

var distance_to_target
@export var target_distance = 2000
@export var fire_rate = 1
var fire_rate_counter = fire_rate


var bullet_scene = load("res://Scenes/bullet.tscn")

func _physics_process(delta: float) -> void:
	distance_to_target = sqrt(pow(self.position.x - target.position.x, 2) + pow(self.position.y - target.position.y, 2))
	if distance_to_target > target_distance:
		fire_rate_counter = fire_rate #resets fire counter when leaving range
		
		velocity = target.position - self.position
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
		enemy_personal_space()
			
		position += velocity * delta
	
	if distance_to_target <= target_distance:
		if fire_rate_counter == 0:
			shoot_bullet()
			fire_rate_counter = fire_rate
		else:
			fire_rate_counter -= 1
			
		velocity = Vector2.ZERO
		enemy_personal_space()
		position += velocity * delta


func shoot_bullet():
	var bullet1 = bullet_scene.instantiate()
	bullet1.shot_Color = self.Ecolor
	bullet1.modulate = Color(bullet1.shot_Color)
	bullet1.position = self.position
	bullet1.velocity = target.position - bullet1.position
	bullet1.target_group = "player" #sets it to collide with only players
	get_parent().add_child(bullet1)
