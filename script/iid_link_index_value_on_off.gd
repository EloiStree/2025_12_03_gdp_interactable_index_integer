class_name IIDLinkIndexValueOnOff extends IIDLinkOnOff
@export var integer_index_value:IIDDataIntegerIndexValueOnOff

signal on_push_request_params(index:int, value:int)

func push_inspector_params_on():
	on_push_request_params.emit(integer_index_value.integer_index, integer_index_value.integer_value.integer_value_on)

func push_inspector_params_off():
	on_push_request_params.emit(integer_index_value.integer_index, integer_index_value.integer_value.integer_value_off)

func set_integer_index(index:int):
	integer_index_value.integer_index =index

func set_integer_value_on(value:int) :
	integer_index_value.integer_value.integer_value_on =value
	
func set_integer_value_off(value:int) :
	integer_index_value.integer_value.integer_value_off =value

func get_integer_index()-> int:
	return integer_index_value.integer_index

func get_integer_value_on()->int :
	return integer_index_value.integer_value.integer_value_on
	
func get_integer_value_off()->int :
	return integer_index_value.integer_value.integer_value_off
	
