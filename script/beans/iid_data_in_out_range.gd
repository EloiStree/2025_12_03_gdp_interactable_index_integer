class_name IIDInOutRange
extends Resource

@export var min_value: float = 0
@export var max_value: float = 0.5

@export var use_enter: bool=true
@export var use_exit: bool=false
@export var integer_in_out : IIDDataIntegerValueOnOff

@export_group("Debug")
@export var current_value_in_range:bool = false
@export var current_value:float = 0




func is_new_value_change_state(value:float) -> bool:
	# Determine whether the value is inside the range
	var is_in_range := value >= min_value and value <= max_value

	# Detect state change (entered or exited range)
	var state_changed := is_in_range != current_value_in_range

	# Update internal state
	current_value_in_range = is_in_range
	current_value = value

	return state_changed

func is_in_range(value:float)->bool:
	return  value >= min_value and value <= max_value

func set_current_value(value:float):
	current_value = value
	current_value_in_range = value >= min_value and value <= max_value
