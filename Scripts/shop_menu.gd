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
	$PauseTabs/Shop/ShopBox/VShopBox/CoinsDisplay.text = str("Coins: ", Global_Variables.coinsHeld)
	$PauseTabs/Shop/ShopBox/VShopBox/ItemsContainer/Shop1.text = str("Fire Rate") # this text is easy to update for random items
	$PauseTabs/Shop/ShopBox/VShopBox/ItemsContainer/Shop2.text = str("Heal") # this text is easy to update for random items
	$PauseTabs/Shop/ShopBox/VShopBox/ItemsContainer/Shop3.text = str("Uhhhhh") # this text is easy to update for random items
	


func _on_shop_1_pressed() -> void:
	if (Global_Variables.coinsHeld >= 3): # the plan -> Change text to upgrade type, display current stat, display upgrade stat, display cost.
			Global_Variables.player1.fire_rate -= 5
			Global_Variables.coinsHeld -= 3
func _on_shop_2_pressed() -> void:
		if (Global_Variables.coinsHeld >= 10) and (Global_Variables.player1.health < 3): # the plan -> Change text to upgrade type, display current stat, display upgrade stat, display cost.
			Global_Variables.player1.health += 1 
			Global_Variables.coinsHeld -= 10
