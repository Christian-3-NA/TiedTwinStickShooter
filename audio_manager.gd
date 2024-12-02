extends Node

var sound_effect_dict = {}
@export var sound_effect_array : Array[SoundEffects]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for sound_effect_iteration : SoundEffects in sound_effect_array:
		sound_effect_dict[sound_effect_iteration.name] = sound_effect_iteration
		

func play_audio(name : SoundEffects.sound_effect_name):
	if sound_effect_dict.has(name):
		var sound_effect : SoundEffects = sound_effect_dict[name]
		var new_audio = AudioStreamPlayer.new()
		new_audio.bus = &"SFX"
		add_child(new_audio)

		new_audio.stream = sound_effect.sound_effect
		new_audio.volume_db = sound_effect.volume
		new_audio.pitch_scale = sound_effect.pitch_scale
		new_audio.process_mode = Node.PROCESS_MODE_ALWAYS # set audio to not stop when game paused
		new_audio.finished.connect(new_audio.queue_free)
		
		new_audio.play()
	else:
		push_error("Audio Manager failed to find setting for name ", name)
