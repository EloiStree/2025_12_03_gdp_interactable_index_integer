class_name UI2DGlueWithButtonsSignalIIDLink
extends Node

@export var parent_to_overwatch: Node

@export var found_buttons: Array[Node] = []
@export var found_link_on_off: Array[IIDLinkOnOff] = []


func _ready() -> void:
	found_buttons.clear()
	found_link_on_off.clear()
	_glue_buttons()


# --------------------------------------------------------------
# Search for all UI nodes (Buttons, CheckBoxes, Sliders…)
# --------------------------------------------------------------
func _search_for_links() -> Array[Node]:
	var results: Array[Node] = []

	if parent_to_overwatch == null:
		push_warning("UI2DGlueWithSignalIIDLink: parent_to_overwatch is null.")
		return results

	var queue: Array[Node] = [parent_to_overwatch]

	while queue.size() > 0:
		var n := queue.pop_front()

		if n is BaseButton or n is Slider:
			results.append(n)

		for child in n.get_children():
			queue.append(child)

	return results


# --------------------------------------------------------------
# Button or Slider event → IIDLinkOnOff
# --------------------------------------------------------------
func _glue_between_button_link_value(node: Node, link: IIDLinkOnOff) -> void:

	# BUTTONS (Button, CheckButton, CheckBox…)
	if node is BaseButton:
		# CheckButtons / CheckBoxes: use toggled
		if node is CheckBox or node is CheckButton:
			node.toggled.connect(func(is_on):
				if is_on:
					link.push_inspector_params_on()
				else:
					link.push_inspector_params_off()
			)
			return
		
		# Normal buttons: use button_down / button_up
		node.button_down.connect(link.push_inspector_params_on)
		node.button_up.connect(link.push_inspector_params_off)



# --------------------------------------------------------------
# Glue all UI nodes with child IIDLinkOnOff
# --------------------------------------------------------------
func _glue_buttons() -> void:
	found_buttons = _search_for_links()

	for ui_element in found_buttons:
		for child in ui_element.get_children():
			if child is IIDLinkOnOff:
				found_link_on_off.append(child)
				_glue_between_button_link_value(ui_element, child)
				continue

	return
