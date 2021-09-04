signal yarned
extends Area2D

export var speed = 400
var screen_size


func _ready():
	screen_size = get_viewport_rect().size
	hide()


func _process(delta):
	var mouse_position = get_global_mouse_position()
	var heading = mouse_position - position
	if Input.is_mouse_button_pressed(1) and (abs(heading[0] + heading[1]) > 4):
		position += heading.normalized() * speed * delta
		position.x = clamp(position.x, 0, screen_size.x)
		position.y = clamp(position.y, 0, screen_size.y)
		if abs(heading[0]) > abs(heading[1]):
			$AnimatedSprite.animation = "walk"
			$AnimatedSprite.flip_v = false
			$AnimatedSprite.flip_h = heading[0] > 0
		elif abs(heading[0]) < abs(heading[1]):
			if heading[1] < 0:
				$AnimatedSprite.animation = "up"
			else:
				$AnimatedSprite.animation = "down"
			


func _on_Player_body_entered(body):
	emit_signal("yarned")
	body.hide()


func start(pos):
	position = pos
	show()
