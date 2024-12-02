extends Area2D

var velocity = Vector2(1, 0)
var speed = 600
var target_group = ""
var target_color = Color(1,1,1,1)
var shot_Color = Color(0.5,.5,0,0)

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
		match target_group:
			"player":
				if shot_Color != area.Pcolor:
					Global_Variables.player_health -= 1
					AudioManager.play_audio(SoundEffects.sound_effect_name.HURT)
					self.queue_free()
			"enemy":
				if shot_Color == area.Ecolor:
					area.health -= 1
					AudioManager.play_audio(SoundEffects.sound_effect_name.ENEMY_HURT)
					self.queue_free()
