signal missed
extends RigidBody2D

export var min_speed = 150
export var max_speed = 250


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("missed")
	queue_free()
