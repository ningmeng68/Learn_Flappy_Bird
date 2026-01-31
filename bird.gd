extends CharacterBody2D

# 物理常量
const JUMP_VELOCITY = -500 # 向上飞行的瞬时速度
const GRAVITY = 1500 # 模拟重力加速度

# 预加载音效资源，提高运行效率
const HIT = preload("res://assets/hit.wav")
const POINT = preload("res://assets/point.wav")
const WING = preload("res://assets/wing.wav")

var rot_degree = 0 # 用于记录当前旋转角度
var is_dead = true # 死亡状态标识，默认死亡（等待游戏正式开始）

@export var max_speed := 700 # 最大下落速度限制，使用@export方便在检查器中微调
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var cpu_particles_2d = $CPUParticles2D
@onready var fly_sound: AudioStreamPlayer2D = $FlySound
@onready var score_sound: AudioStreamPlayer2D = $ScoreSound

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# 当小鸟存活时
	if not is_dead:
		# 应用重力
		velocity.y += GRAVITY * delta
		
		# 检测到玩家输入“fly”动作
		if Input.is_action_just_pressed("fly"):
			velocity.y = JUMP_VELOCITY # 给小鸟一个向上的速度
			fly_sound.stream = WING # 设置扑翼音效
			fly_sound.play() # 播放音效
			
		# 计算旋转角度：根据纵向的速度改变俯仰角
		# 使用clampf限制俯仰角在（-30°，30°）
		rot_degree = clampf(-30 * velocity.y / JUMP_VELOCITY, -30, 30)
		rotation_degrees = rot_degree
		
		# 速度限制
		velocity.y = clampf(velocity.y, -max_speed, max_speed)
		
		# 执行移动
		move_and_slide()
