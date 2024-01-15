extends CharacterBody2D

enum States{
	Left,
	Right,
	Idle
}

var cur = move_check()

func move_check():
	if Input.is_action_pressed("ui_right"): cur = States.Right
	if Input.is_action_pressed("ui_left"): cur = States.Left
	
	else: cur = States.Idle
	
func state():
	match cur:
		States.Right:
			velocity.x += 40
		States.Left:
			velocity.x -= 40
		States.Idle:
			velocity.x =0
			
func _physics_process(delta):
	move_check()
	state()
	print(Input.is_action_pressed("ui_right"))
	move_and_slide()
