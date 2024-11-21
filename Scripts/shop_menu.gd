extends Control

func _ready():
	$BlurAnimator.play("RESET")
	hide()
	
	
func resume():
	get_tree().paused = false
	$BlurAnimator.play_backwards("blur")
	hide()
	
	
func pause():
	get_tree().paused = true
	$BlurAnimator.play("blur")
	show()
	
	
func test_shop_open():
	if Input.is_action_just_pressed("open_shop") and !get_tree().paused:
		$PauseTabs.current_tab = 0
		pause()
	elif Input.is_action_just_pressed("open_inventory") and !get_tree().paused:
		$PauseTabs.current_tab = 1
		pause()
	elif Input.is_action_just_pressed("open_pause") and !get_tree().paused:
		$PauseTabs.current_tab = 2
		pause()
	elif (Input.is_action_just_pressed("open_shop") or Input.is_action_just_pressed("open_inventory") or Input.is_action_just_pressed("open_pause")) and get_tree().paused:
		resume()


func _on_exit_button_pressed() -> void:
	resume()


func _on_quit_button_pressed() -> void:
	resume()
	Signals.game_over.emit()


func _process(delta):
	test_shop_open()
