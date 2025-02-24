extends Node

class_name CoinGenerator

enum CoinPattern {
	LINE,
	S_LINE,
	DIAMOND,
	CIRCLE
}

const MARGIN = 10

func get_coin_pattern(pattern: CoinPattern) -> Array[Vector2]:
	var coins: Array[Vector2] = []
	match pattern:
		CoinPattern.LINE:
			coins = get_coin_line()
		CoinPattern.S_LINE:
			coins = get_coin_s_line()
		CoinPattern.DIAMOND:
			coins = get_coin_diamond()
		CoinPattern.CIRCLE:
			coins = get_coin_circle()
	return coins
	
func get_coin_line() -> Array[Vector2]:
	return _generate_coins([[0, 0], [50, 0], [100, 0]])
	
func get_coin_s_line() -> Array[Vector2]:
	return _generate_coins([[0, 10], [50, 0], [100, 15], [150, 40], [200, 25], [250, 10]])
	
func get_coin_diamond() -> Array[Vector2]:
	return _generate_coins([[50, 100], [50, 0], [100, 50], [0, 50]])
	
func get_coin_circle() -> Array[Vector2]:
	return _generate_coins([[70, 140],[70, 0], [140, 70], [0, 70], [120, 120], [20, 20], [120, 20], [20, 120]])

func _generate_coins(coin_data) -> Array[Vector2]:
	var coin_positions: Array[Vector2] = []
	var max_y = _get_y_max_from(coin_data)
	var offset = Vector2(
		int(GameManager.VIEWPORT_SIZE.x) + 50, 
		max(randi() % (int(GameManager.VIEWPORT_SIZE.y) - max_y - MARGIN), MARGIN)
	)
	for data_point in coin_data:
		coin_positions.push_back(Vector2(data_point[0] + offset.x, data_point[1] + offset.y))
	return coin_positions
	
func _get_y_max_from(coin_data: Array) -> int:
	coin_data.sort_custom(func(data1, data2): return data1[1] > data2[1])
	return coin_data[0][1]


func _get_y_min_from(coin_data) -> int:
	coin_data.sort_custom(func(data1, data2): return data1[1] < data2[1])
	return coin_data[0][1]
		
