extends CanvasLayer

signal start_game

func _on_button_pressed():
	$Button.hide()
	start_game.emit()

func update_score(score):
	$Score.text = str(score)

func game_over(text):
	$Message.text = text
	$Message.show()
	
	$Timer.start()
	await $Timer.timeout
	get_tree().call_group("Obs","queue_free")
	update_score(0)
	$Button.show()
	$Message.hide()
