class_name IIDLinkOnOff extends Node

@export var description:String="[Complete with waht it does]"

func get_description() -> String:
	return description

func push_inspector_params_on():
	assert(false, "push_inspector_params_on() must be overridden in a subclass!")

func push_inspector_params_off():
	assert(false, "push_inspector_params_off() must be overridden in a subclass!")
