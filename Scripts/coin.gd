extends Area2D

func _on_area_entered(area: Area2D) -> void: # Grab coin when player enters hitbox (Might be better to do this on players logic)
	if area.is_in_group("player"):
		Signals.coin_collected.emit()
		queue_free()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("Sprite2D").modulate = Color8(252, 186, 3)  # Sets color to goldish


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
