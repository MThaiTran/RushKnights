extends CharacterBody2D

const speed = 50 * 2
const jump_force = 400
const gravity = 40
const MAX_FORCE = 200

var sprint_speed=1

func _ready():
	hide()
	
func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > MAX_FORCE : velocity.y = MAX_FORCE
		
	velocity.x=0
	if Input.is_action_pressed("move_left"):
		velocity.x = -1 * speed * sprint_speed
	if Input.is_action_pressed("move_right"):
		velocity.x = 1  * speed * sprint_speed
	if Input.is_action_pressed("jump") && is_on_floor():
		jump()

	if velocity.x!=0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
		$AnimatedSprite2D.play("run")
	else : 
		$AnimatedSprite2D.play("idle")
		
	position.x= clamp(position.x,0.0,240.0)
	position.y = clamp(position.y,0.0,281.0)
	move_and_slide()

func jump():
	velocity.y = -jump_force
	var sound = get_node("/root/Main/Sounds/JumpEffect")
	sound.play()
	
func start():
	position = Vector2(32,272)
	$CollisionShape2D.set_deferred("disabled",false)
	$CollisionShape2D.set_deferred("disabled",false)
	show()
