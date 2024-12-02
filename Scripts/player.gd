extends Area2D

@export var controls: Resource = null
var velocity = Vector2.ZERO
var speed = 400
var Pcolor = Color(1,1,1,1)
var maxHealth = 3
var health = 3
var prev_health = health
var damage = 1 
var size = 2 #temp
var p_range = 3
var fire_rate = 30
var fire_rate_counter = fire_rate
var shotNum = 1
var crit = 0.0
var range:int = 320
var invincible_bool = false
var draw_invince = false

#Default player values

var bullet_scene = load("res://Scenes/bullet.tscn")
var targetable_enemies = []
var partner_pos = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.range_updated.connect(_on_range_updated)

func _physics_process(delta: float) -> void:
	if fire_rate_counter == 0:
		if targetable_enemies.size() > 0:
			shoot_bullet()
			fire_rate_counter = fire_rate
	else:
		fire_rate_counter -= 1
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2.ZERO
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
	player_rope_pull()
	
	position += velocity * delta
		
		
	#temporay way to show controls
	if get_parent().get_name() == "Level":
		var controls_hint = ""
		if self == Global_Variables.player1:
			controls_hint = "WASD"
		if self == Global_Variables.player2:
			controls_hint = "<^>"
		$TempHealthDisplay.text = str(controls_hint)
		
		
	#this is the constant check for immunity frames 
	if (prev_health != Global_Variables.player_health):
		#this if statement prevents taking like 5 damage at once
		if prev_health > Global_Variables.player_health + 1:
			Global_Variables.player_health = prev_health - 1
		prev_health = Global_Variables.player_health
		var p1oColor = Global_Variables.player1.Pcolor
		var p2oColor = Global_Variables.player2.Pcolor
		
		#Global_Variables.player1.get_node("Hurtbox").disabled = true
		#Global_Variables.player2.get_node("Hurtbox").disabled = true
		invincible_bool = true
		draw_invince = true
		queue_redraw()
		
		await get_tree().create_timer(3.0).timeout
		#Global_Variables.player1.get_node("Hurtbox").disabled = false
		#Global_Variables.player2.get_node("Hurtbox").disabled = false
		invincible_bool = false
		draw_invince = false
		queue_redraw()
		
		
	if Global_Variables.player_health <= 0:		#better to do the check on when health decreases (bullet script currently)
		die()
	

func shoot_bullet() -> void:
	'''
	SORTS TARGETS IN RANGE BY DISTANCE EVERY TIME YOU SHOOT
	IF GAME IS LAGGY TRY OPTIMIZING THIS FIRST
	'''
	targetable_enemies.sort_custom(sort_distance) #sorts targets by distance
	
	var bullet1 = bullet_scene.instantiate()
	bullet1.shot_Color = self.Pcolor
	bullet1.modulate = Color(bullet1.shot_Color)
	bullet1.position = self.position
	bullet1.velocity = targetable_enemies[0].position - bullet1.position
	bullet1.target_group = "enemy" #sets it to collide with only enemies
	bullet1.target_color = self.Pcolor
	AudioManager.play_audio(SoundEffects.sound_effect_name.SHOOT)
	get_parent().add_child(bullet1)


func _on_attack_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") and area.Ecolor == self.Pcolor:
		targetable_enemies.append(area)
	elif area.is_in_group("coin"):
		if area.Ccolor == Pcolor:
			area.move_to = self


func _on_attack_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("enemy") and area.Ecolor == self.Pcolor:
		targetable_enemies.erase(area)


func _draw():
	draw_arc(Vector2.ZERO, $AttackArea/CollisionShape2D.shape.radius, 0, 360, 50, Pcolor, 2, true)
	if draw_invince:
		draw_circle(Vector2.ZERO, $Hurtbox.shape.radius+10, Color(1,1,1,.5))

	
func player_rope_pull():
	var p = get_parent()
	if p.get_name() == "Level":
		if p.distance >= Global_Variables.rope_pulling_length:
			self.velocity += position.direction_to(partner_pos) * ((p.distance - Global_Variables.rope_pulling_length)/(Global_Variables.max_rope_length - Global_Variables.rope_pulling_length) * speed)


#custom sort for determining closest enemy to target
func sort_distance(a, b):
	if (sqrt(pow(self.position.x - a.position.x, 2) + pow(self.position.y - a.position.y, 2))) < (sqrt(pow(self.position.x - b.position.x, 2) + pow(self.position.y - b.position.y, 2))):
		return true
	return false
	

func die():
	Global_Variables.coinsHeld = 0
	Signals.game_over.emit()
	self.queue_free()


func _on_range_updated() -> void:
	queue_redraw()
