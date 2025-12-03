class_name UIOverwatchChildIntegerRelay
extends Node

# ----------------------------------------------------
# SIGNALS
# ----------------------------------------------------
signal on_integer_value_relayed(integer_value: int)
signal on_integer_index_value_relayed(integer_index: int, integer_value: int)

# Node to scan for child relays
@export var parent_to_overwatch: Node


# ----------------------------------------------------
# PUBLIC RELAY METHODS
# ----------------------------------------------------
func relay_child_value(value_to_relay: int) -> void:
	on_integer_value_relayed.emit(value_to_relay)


func relay_child_index_value(index_to_relay: int, value_to_relay: int) -> void:
	on_integer_index_value_relayed.emit(index_to_relay, value_to_relay)


# ----------------------------------------------------
# LIFECYCLE
# ----------------------------------------------------
func _ready() -> void:
	if parent_to_overwatch == null:
		push_warning("UIOverwatchChildIntegerRelay: parent_to_overwatch is NULL.")
		return

	_find_and_glue_relays(parent_to_overwatch)


# ----------------------------------------------------
# SEARCH + GLUE LOGIC
# ----------------------------------------------------
func _find_and_glue_relays(node: Node) -> void:

	# Detect and glue basic integer relays
	if node is IIDChildValueRelay:
		_glue_value_relay(node as IIDChildValueRelay)

	# Detect and glue index-value relays
	if node is IIDChildIndexValueRelay:
		_glue_index_value_relay(node as IIDChildIndexValueRelay)

	# Recurse into children
	for child in node.get_children():
		_find_and_glue_relays(child)


# ----------------------------------------------------
# GLUE HELPERS
# ----------------------------------------------------
func _glue_value_relay(relay: IIDChildValueRelay) -> void:
	if relay.on_value_relayed.is_connected(relay_child_value):
		return
	relay.on_value_relayed.connect(relay_child_value)
	print("Linked IIDChildValueRelay →", relay.name)


func _glue_index_value_relay(relay: IIDChildIndexValueRelay) -> void:
	if relay.on_index_value_relayed.is_connected(relay_child_index_value):
		return
	relay.on_index_value_relayed.connect(relay_child_index_value)
	print("Linked IIDChildIndexValueRelay →", relay.name)
