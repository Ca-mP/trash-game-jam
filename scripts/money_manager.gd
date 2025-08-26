extends Node

signal update_money_amt(money_amt: float)

var money_amt: float = 0.0

func get_money(amt: float):
	money_amt += amt
	update_money_amt.emit(money_amt)
