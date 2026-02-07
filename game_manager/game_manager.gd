extends Node

# 定义三种全局信号
signal GameStart # 游戏开始
signal GameOver # 游戏结束
signal UpdateScore # 更新分数

var score = 0 # 全局分数变量

func _ready() -> void:
	# 监听信号连接到响应函数，用于处理数据更新
	UpdateScore.connect(add_score)
	GameOver.connect(on_game_over)
	
# 分数加1
func add_score():
	score += 1

# 游戏结束，重置分数
func on_game_over():
	score = 0
