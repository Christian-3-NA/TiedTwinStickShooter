extends Resource
class_name SoundEffects
enum sound_effect_name{
	SHOOT,
	HURT,
	COIN_COLLECT,
	SHOP_BUY,
	GAME_OVER,
	BUTTON,
	VOLUME_TEST,
	ENEMY_HURT,
	ENEMY_DEAD
}

@export var name : sound_effect_name
@export var sound_effect : AudioStreamMP3
@export var volume = 0
@export var pitch_scale = 1.0
	
