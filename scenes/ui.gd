extends CanvasLayer

@export var money_counter: Label

func _ready() -> void:
	MoneyManager.update_money_amt.connect(update_money)

func update_money(amt: float):
	money_counter.text = str(amt)
