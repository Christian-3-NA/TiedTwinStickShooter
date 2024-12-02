extends Resource
class_name SoundEffects
enum sound_effect_name{
	SHOOT,
	HURT,
	COIN_COLLECT,
	SHOP_BUY
}

@export var name : sound_effect_name
@export var sound_effect : AudioStreamMP3
	
