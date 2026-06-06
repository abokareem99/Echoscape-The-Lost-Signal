extends PointLight2D

@export var max_scale: float = 4.0
@export var pulse_duration: float = 0.3
@export var fade_duration: float = 1.5

func _input(event: InputEvent) -> void:
	# التحقق من ضغط زر الفأرة الأيسر لإطلاق النبضة
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		trigger_pulse()

func trigger_pulse() -> void:
	# إنشاء تتابع حركي (Tween) لتكبير الإضاءة ثم إخفائها
	var tween := create_tween()
	
	# 1. تكبير حجم النبضة الضوئية بسرعة لتكشف المكان
	tween.tween_property(self, "texture_scale", max_scale, pulse_duration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.OUT)
	
	# 2. تلاشي الضوء تدريجياً ليعود الظلام مجدداً
	tween.tween_property(self, "texture_scale", 0.0, fade_duration).set_trans(Tween.TRANS_LINEAR).set_delay(0.1)