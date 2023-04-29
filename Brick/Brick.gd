extends StaticBody2D

var score = 0
var new_position = Vector2.ZERO
var dying = false

var powerup_prob = 0.1

func _ready():
	randomize()
	position = new_position
	if score >= 100:
		$ColorRect.color = Color8(175,94,94)
	elif score >= 90:
		$ColorRect.color = Color8(27,94,18)
	elif score >= 80:
		$ColorRect.color = Color8(68,39,198)
	elif score >= 70:
		$ColorRect.color = Color8(120,179,180)
	elif score >= 60:
		$ColorRect.color = Color8(79,79,120)
	elif score >= 50:
		$ColorRect.color = Color8(145,1,90)
	elif score >= 40:
		$ColorRect.color = Color8(150, 79, 10)
	elif score >= 30:
		$ColorRect.color = Color8(16,46,36)



func _physics_process(_delta):
	if dying and not $Confetti.emitting:
		queue_free()

func hit(_ball):
	$Confetti.emitting = true
	var wall_sound = get_node_or_null("/root/Game/Brick_Sound")
	if wall_sound != null:
		wall_sound.play()
	die()

func die():
	dying = true
	collision_layer = 0
	$ColorRect.hide()
	Global.update_score(score)
	if not Global.feverish:
		Global.update_fever(score)
	get_parent().check_level()
	if randf() < powerup_prob:
		var Powerup_Container = get_node_or_null("/root/Game/Powerup_Container")
		if Powerup_Container != null:
			var Powerup = load("res://Powerups/Powerup.tscn")
			var powerup = Powerup.instance()
			powerup.position = position
			Powerup_Container.call_deferred("add_child", powerup)
