
class_name IIDChildIndexValueRelay extends Node

signal on_index_value_relayed(index_to_relay:int , value_to_relay:int)

func push_index_integer(index_to_relay:int , value_to_relay:int):
	on_index_value_relayed.emit(index_to_relay, value_to_relay)
