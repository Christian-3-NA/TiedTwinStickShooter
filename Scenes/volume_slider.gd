extends HSlider

@export var bus_name: String
var bus_index
var slider_being_moved

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value)) #convert 0-1 to audio friendly scaling -80 to 0?
	if(slider_being_moved):
		AudioManager.play_audio(SoundEffects.sound_effect_name.VOLUME_TEST)



func _on_drag_started() -> void:
	slider_being_moved = true


func _on_drag_ended(value_changed: bool) -> void:
	slider_being_moved = false
