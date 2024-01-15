extends AnimatableBody2D

var speed = 16*4

func _process(delta):
	position += Vector2.DOWN * speed * delta
