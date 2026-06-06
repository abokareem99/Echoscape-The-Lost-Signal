extends Node

# ربط واجهات المستخدم والروابط الخارجية (تأكد من وجود هذه العقد في المشهد لاحقاً)
@onready var player: CharacterBody2D = $Player
@onready var battery_system: Node = $BatterySystem
@onready var hud: CanvasLayer = $HUD

var score: int = 0
var is_game_over: bool = false

func _ready() -> void:
	print("تم بدء اللعبة بنجاح! جاري تهيئة الأنظمة...")
	score = 0
	is_game_over = false
	# تحديث الواجهة بقيم الطاقة المبدئية
	if hud:
		hud.update_energy_bar(battery_system.current_energy)
		hud.update_score(score)

func _process(_delta: float) -> void:
	if is_game_over:
		return

	# التحقق المستمر من طاقة اللاعب
	if battery_system and battery_system.current_energy <= 0:
		trigger_game_over()

func _input(event: InputEvent) -> void:
	if is_game_over:
		# إذا انتهت اللعبة وضغط اللاعب زر المسافة (Space)، يتم إعادة تشغيل المرحلة
		if event.is_action_pressed("ui_accept"):
			reload_current_level()
		return

	# عند الضغط على زر الفأرة الأيسر لإطلاق النبضة
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if battery_system and battery_system.use_pulse():
			# إذا نجح إطلاق النبضة واستهلاك الطاقة، نقوم بتحديث الواجهة
			hud.update_energy_bar(battery_system.current_energy)
			# تفعيل الأنيميشن الخاص بالنبضة في عنصر الإضاءة التابع للاعب
			player.get_node("PointLight2D").trigger_pulse()

# دالة تُستدعى عند جمع الموارد المتوهجة لزيادة النقاط وشحن الطاقة
func collect_energy_pickup(amount: float) -> void:
	if is_game_over: return
	
	battery_system.recharge(amount)
	score += 10 # إضافة 10 نقاط لكل كبسولة طاقة
	
	hud.update_energy_bar(battery_system.current_energy)
	hud.update_score(score)

# دالة إنهاء اللعبة عند نفاد الطاقة
func trigger_game_over() -> void:
	is_game_over = true
	print("انتهت اللعبة! نفدت طاقة الروبوت في الظلام.")
	if hud:
		hud.show_game_over_screen()

# إعادة تشغيل المرحلة الحالية
func reload_current_level() -> void:
	get_tree().reload_current_scene()