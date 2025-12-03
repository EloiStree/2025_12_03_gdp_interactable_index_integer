class_name UI2DBroadcastControlButtonsOnOff
extends Node

signal on_integer_value_relayed(integer_value: int)
signal on_integer_index_value_relayed(integer_index: int, integer_value: int)

@export var parent_to_overwatch: Node


func relay_iid_value(value_to_relay: int) -> void:
	on_integer_value_relayed.emit(value_to_relay)


func relay_iid_index_value(index_to_relay: int, value_to_relay: int) -> void:
	on_integer_index_value_relayed.emit(index_to_relay, value_to_relay)


func _ready() -> void:
	if parent_to_overwatch == null:
		push_warning("UI2DBroadcastControlOnOff: parent_to_overwatch is NULL.")
		return

	_find_and_glue_links(parent_to_overwatch)


### ----------------------------------------------------
### LINK SEARCH + GLUE
### ----------------------------------------------------

func _find_and_glue_links(node: Node) -> void:

	# If node is a value-only link
	if node is IIDLinkValueOnOff:
		_glue_link_value(node as IIDLinkValueOnOff)

	# If node is an index+value link
	if node is IIDLinkIndexValueOnOff:
		_glue_link_index_value(node as IIDLinkIndexValueOnOff)

	# Continue recursively for children
	for child in node.get_children():
		if child is Node:
			_find_and_glue_links(child)


### ----------------------------------------------------
### GLUE HELPERS
### ----------------------------------------------------

func _glue_link_value(link: IIDLinkValueOnOff) -> void:
	if link.on_push_request_params.is_connected(relay_iid_value):
		return
	link.on_push_request_params.connect(relay_iid_value)
	print("Linked IIDLinkValueOnOff →", link.name)


func _glue_link_index_value(link: IIDLinkIndexValueOnOff) -> void:
	if link.on_push_request_params.is_connected(relay_iid_index_value):
		return
	link.on_push_request_params.connect(relay_iid_index_value)
	print("Linked IIDLinkIndexValueOnOff →", link.name)
