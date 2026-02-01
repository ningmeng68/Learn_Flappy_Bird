extends Node2D

const SPEED = -150 # 向左移动的速度
var passed = false # 标记小鸟是否通过此管道

@onready var coin: Area2D = $Coin
@onready var pipe_bottom: Area2D = $PipeBottom
@onready var pipe_top: Area2D = $PipeTop
@onready var animation_player: AnimationPlayer = $Coin/AnimationPlayer
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# 当小鸟触碰到上下管道触发
	pipe_top.body_entered.connect(on_pipe_body_entered)
	pipe_bottom.body_entered.connect(on_pipe_body_entered)
	
	# 当小鸟触碰到金币触发
	coin.body_entered.connect(on_coin_body_entered)
	
	# 当管道离开屏幕时触发
	visible_on_screen_notifier_2d.screen_exited.connect(on_exited)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# 管道的移动
	position.x += SPEED * delta
	
func on_pipe_body_entered(body):
	if body.is_in_group("bird") and not body.is_dead:
		# TODO：触发游戏结束逻辑
		pass

# 将管道从场景树移除，释放内存
func on_exited():
	queue_free()

func on_coin_body_entered(body):
	if body.is_in_group("bird") and not passed:
		passed = true # 设置为已通过
		
		animation_player.play("coin") # 播放金币消失动画
		await animation_player.animation_finished # 等待动画播放完
		
		coin.queue_free() # 删除金币节点
		
