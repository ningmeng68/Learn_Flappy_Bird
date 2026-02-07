extends ParallaxBackground

const SPEED = -150 # 移动速度

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# scroll_offset是内置属性，用于控制背景的移动
	scroll_offset.x += SPEED * delta
