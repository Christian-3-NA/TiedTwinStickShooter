extends Area2D

@export var controls: Resource = null
var speed = 400
var Pcolor = Color (255,255,255,1)
var health = 3
var damage = 1
var size = 2 #temp
var fire_rate = 60
var fire_rate_counter = fire_rate
#Default player values

var bullet_scene = load("res://Scenes/bullet.tscn")
var targetable_enemies = []

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
	
	
	if fire_rate_counter == 0:
		if targetable_enemies.size() > 0:
			shoot_bullet()
			fire_rate_counter = fire_rate
	else:
		fire_rate_counter -= 1
	

func shoot_bullet() -> void:
	'''
	SORTS TARGETS IN RANGE BY DISTANCE EVERY TIME YOU SHOOT
	IF GAME IS LAGGY TRY OPTIMIZING THIS FIRST
	'''
	targetable_enemies.sort_custom(sort_distance) #sorts targets by distance
	
	var bullet1 = bullet_scene.instantiate()
	bullet1.position = self.position
	bullet1.velocity = targetable_enemies[0].position - bullet1.position
	bullet1.target_group = "enemy" #sets it to collide with only enemies
	get_parent().add_child(bullet1)


func _on_attack_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		targetable_enemies.append(area)


func _on_attack_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		targetable_enemies.erase(area)


func _draw():
	draw_arc(Vector2.ZERO, $AttackArea/CollisionShape2D.shape.radius, 0, 360, 50, Pcolor, 2, true)
	

#custom sort for determining closest enemy to target
func sort_distance(a, b):
	if (sqrt(pow(self.position.x - a.position.x, 2) + pow(self.position.y - a.position.y, 2))) < (sqrt(pow(self.position.x - b.position.x, 2) + pow(self.position.y - b.position.y, 2))):
		return true
	return false
