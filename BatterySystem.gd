extends Node

@export var max_energy: float = 100.0
var current_energy: float = 100.0

@export var pulse_cost: float = 15.0

func _ready() -> void:
	current_energy = max_energy

func use_pulse() -> bool:
	if current_energy >= pulse_cost:
		current_energy -= pulse_cost
		print("الطاقة المتبقية: ", current_energy)
		return true
	else:
		print("الطاقة منخفضة جداً!")
		return false

func recharge(amount: float) -> void:
	current_energy = min(current_energy + amount, max_energy)
	print("تم الشحن، الطاقة الحالية: ", current_energy)