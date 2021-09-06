extends Node

export (PackedScene) var Yarn
var misses = 3
var score


func _ready():
	randomize()
	$Player.connect("yarned", self, "_on_Yarn_cought")
	new_game()

func _process(_delta):
	$HUD.update_score(score)
	if misses < 0:
		game_over()


func game_over():
	$HUD.show_game_over()
	$YarnTimer.stop()


func new_game():
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	


func _on_StartTimer_timeout():
	$YarnTimer.start()


func _on_YarnTimer_timeout():
	$YarnPath/YarnSpawnLocation.offset = randi()
	var yarn = Yarn.instance()
	add_child(yarn)
	yarn.connect("missed", self, "_on_Yarn_miss")
	var direction = $YarnPath/YarnSpawnLocation.rotation + PI / 2
	yarn.position = $YarnPath/YarnSpawnLocation.position
	direction += rand_range(-PI / 4, PI / 4)
	yarn.rotation = direction
	yarn.linear_velocity = Vector2(rand_range(yarn.min_speed, yarn.max_speed), 0)
	yarn.linear_velocity = yarn.linear_velocity.rotated(direction)


func _on_Yarn_miss():
	misses -= 1


func _on_Yarn_cought():
	misses = 3
	score += 1
