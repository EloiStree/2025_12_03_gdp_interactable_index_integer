
class_name IIDChildValueRelay extends Node

signal on_value_relayed(value_to_relay:int)

func push_integer(value_to_relay:int):
	on_value_relayed.emit(value_to_relay)
