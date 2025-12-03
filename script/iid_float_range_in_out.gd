class_name IIDFloatRangeInOut
extends IIDChildValueRelay

@export var current_value:float = 0
@export var in_out_range:IIDInOutGroupRange

func _ready() -> void:
	in_out_range = in_out_range.duplicate(true)

func set_current_value(value:float):
	current_value = value

	# Loop all ranges
	for range_item in in_out_range.group:
		var changed := range_item.is_new_value_change_state(value)
		range_item.set_current_value(value)
		if changed:
			var found_integer_value:int
			var is_in_range :bool = range_item.is_in_range(value)
			
			if is_in_range:
				found_integer_value = range_item.integer_in_out.integer_value_on
			else:
				found_integer_value = range_item.integer_in_out.integer_value_off

			push_integer( found_integer_value)


func _on_v_slider_trigger_right_value_changed(value: float) -> void:
	pass # Replace with function body.
