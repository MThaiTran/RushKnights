extends Node2D

@export var platform:PackedScene
@export var P2 : PackedScene
var x_cell = [-32 , -16 , 0 , 16 , 32 , 48 , 64 , 80 , 96 , 112 , 128 , 144 , 160 , 176 , 192 , 208 , 224]

var post_postition = -32
var post_type = 2
var score 
	
func _on_wall_timer_timeout():
	var ground_platform = platform.instantiate()
	ground_platform.position.y = 0
	ground_platform.position.x = choose_type([4]  , post_postition)
	post_postition = ground_platform.position.x
	add_child(ground_platform)
	
var check = false

func exit(body):
	if check == false : 
		$Lava.show()
		$Lava/CollisionShape2D.set_deferred("disabled",false)
		check = true
	if body is AnimatableBody2D:
		body.queue_free()
	
func choose_type(dis,prev_post):
	var dir = [-1,1].pick_random()
	var distance = dis.pick_random() * dir
	while (prev_post + distance*16 < -32) || (prev_post + distance*16 > 224):
		dir*=-1
		distance = dis.pick_random() * dir
	return prev_post + distance*16

func _ready():
	$Lava.hide()
	$Lava/CollisionShape2D.set_deferred("disabled",true)
	
func _on_score_timer_timeout():
	score+=1
	$Menu.update_score(score)

var mode 
var Pwon

func game_over(body):
	if !(body is CharacterBody2D): return 
	if mode == 1 :
		if body.name == "Player":
			$Player.hide()
			$Player/CollisionShape2D.set_deferred("disabled",true)
			$WallTimer.stop()
			$ScoreTimer1.stop()
			$Menu.game_over("Game Over")
			$Sounds/GameOver.play()
	elif mode == 2 :
		if body.name == "Player": Pwon = "Player 2 won"
		elif body.name == "Player_2": Pwon = "Player 1 won"
		print(Pwon)
		$Player.hide()
		$Player/CollisionShape2D.set_deferred("disabled",true)
#		$Player_2.hide()
#		$Player_2/CollisionShape2D.set_deferred("disabled",true)
		$Player_2.queue_free()
		$Sounds/GameOver.play() 
		$WallTimer.stop()
		$ScoreTimer1.stop()
		$Menu.game_over(Pwon)

func _on_music_finished():
	$Sounds/Music.play()

func _on_menu_start_1():
	mode = 1
	start_game()
	$Player.start()
	$ScoreTimer1.start()

func _on_menu_start_2():
	_on_menu_start_1()
	mode = 2
	var player2 = P2.instantiate()
	player2.start()
	add_child(player2)
	
func start_game():
	score = 0
	$Sounds/Music.play()
	$WallTimer.start()
	$Lava.hide()
	$Lava/CollisionShape2D.set_deferred("disabled",true)
	check = false
