extends Node

func _on_timer_timeout():
	var check=[0,1].pick_random()
	print(check)
	if check==1:
		$Timer.wait_time = 10
		$Timer.start()
		print("Type_2" , $Timer.wait_time)
	else :
		$Timer.wait_time = 5
		$Timer.start()
		print("Type_1" , $Timer.wait_time)
