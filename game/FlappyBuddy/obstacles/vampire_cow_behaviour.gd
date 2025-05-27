extends ObstacleBehaviour

class_name VampireCowBehaviour

const OBSTACLE_DATA_BLOOD_DROP = preload("res://obstacles/obstacle_data_blood_drop.tres")

enum Phases {
	INIT,
	IDLE,
	ATTACK,
	FIRE,
	RETURN
}
var current_phase = Phases.INIT
var total_attacks = 3
var current_round = 0

var idle_time = 0
var idle_times = [2.5, 1.8, 3.3]
var dir = -1

var shots = [1,2,4]
var shot_amount = 0
var shot_conf = [
	{"pos_x": 400, "trajektories": [[50,1,-60]]},
	{"pos_x": 460, "trajektories": [[80,-5,-80], [70, 10,-40]]}, # 2.schuss 1. größer
	{"pos_x": 500, "trajektories": [[-50,-75,-95], [12,-3,-12], [40,60,80], [30,1,-30]]} # 3. schuss anpassen (für oben fliegen
]
var fire_time = 0
var has_fired = false
var game


func _entry(vampire_cow: Obstacle):
	vampire_cow._play_entry_sound()
	var sprite = vampire_cow.animation_instance
	if sprite is AnimatedSprite2D:
		sprite.play("fly")
	else:
		push_error("animation_instance ist kein AnimatedSprite2D!")	
	game = vampire_cow.get_parent()


func _on_player_collide(vampire_cow: Obstacle, player: Player):
	player.state = "died"
	GameManager.update_state(player, [vampire_cow])
	GameManager.game_over()

func _move(delta: float, vampire_cow: Obstacle):
	match current_phase:
		Phases.INIT:
			vampire_cow.position.x -= delta * vampire_cow.obstacle_data.speed / 7
			if vampire_cow.position.x <= 600:
				current_phase = Phases.IDLE
		Phases.IDLE:
			vampire_cow.animation_instance.play("default")
			idle_time += delta
			if vampire_cow.position.y < 50:
				dir = 1
			if vampire_cow.position.y > 460:
				dir = -1
			vampire_cow.position.y += delta * vampire_cow.obstacle_data.speed_y * dir
			if idle_time >= idle_times[current_round]:
				current_phase = Phases.ATTACK
		Phases.ATTACK:
			vampire_cow.animation_instance.play("fly")
			vampire_cow.position.x -= delta * vampire_cow.obstacle_data.speed
			if vampire_cow.position.x <= shot_conf[current_round].pos_x and shot_amount < shots[current_round]:
				fire_time = 0
				has_fired = false
				current_phase = Phases.FIRE
			if vampire_cow.position.x < 30 and current_round < total_attacks-1:
				current_phase = Phases.RETURN
			if vampire_cow.position.x < -50:
				vampire_cow.queue_free()
		Phases.FIRE:
				fire_time += delta
				if fire_time > 0.2 and fire_time < 0.4:
					vampire_cow.animation_instance.play("fire")
					if not has_fired:
						if game:
							var cows_mouth = Vector2(vampire_cow.position.x - 24, vampire_cow.position.y - 2) 
							game.spawn(OBSTACLE_DATA_BLOOD_DROP, cows_mouth, shot_conf[current_round].trajektories[shot_amount][0])
							game.spawn(OBSTACLE_DATA_BLOOD_DROP, cows_mouth, shot_conf[current_round].trajektories[shot_amount][1])
							game.spawn(OBSTACLE_DATA_BLOOD_DROP, cows_mouth, shot_conf[current_round].trajektories[shot_amount][2])
							has_fired = true
							shot_amount += 1
				else:
					vampire_cow.animation_instance.play("default")
				if fire_time > 0.6:
					current_phase = Phases.ATTACK
		Phases.RETURN:
			vampire_cow.animation_instance.play("default")
			vampire_cow.position.x += delta * (vampire_cow.obstacle_data.speed - 250)
			if vampire_cow.position.x >= 600:
				shot_amount = 0
				current_round += 1
				idle_time = 0
				current_phase = Phases.IDLE

func _on_player_close_area(vampire_cow: Obstacle, player: Player):
	player.close_enough(vampire_cow.obstacle_data.points)
