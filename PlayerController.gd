extends CharacterBody2D

@export var SPEED: float = 250.0
@export var FRICTION: float = 0.2

func _physics_process(_delta: float) -> void:
	# جلب اتجاه الحركة من أزرار WASD أو الأسهم
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
	else:
		# تباطؤ سلس وتدريجي عند الإفلات لتأثير حركة الروبوت
		velocity = velocity.lerp(Vector2.ZERO, FRICTION)

	move_and_slide()