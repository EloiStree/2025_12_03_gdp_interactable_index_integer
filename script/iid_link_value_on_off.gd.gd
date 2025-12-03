class_name IIDLinkValueOnOff extends IIDLinkOnOff
@export var integer_value:IIDDataIntegerValueOnOff

signal on_push_request_params(value:int)

func push_inspector_params_on():
	on_push_request_params.emit( integer_value.integer_value_on)

func push_inspector_params_off():
	on_push_request_params.emit(integer_value.integer_value_off)

func get_integer_value_on()->int :
	return integer_value.integer_value_on
	
func get_integer_value_off()->int :
	return integer_value.integer_value_off
	
func set_integer_value_on(value:int) :
	integer_value.integer_value_on =value
	
func set_integer_value_off(value:int) :
	integer_value.integer_value_off =value
	
