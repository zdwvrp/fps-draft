class_name Game_Object extends Node

var is_interactable: bool = false

func _init(args):
	set_is_interactable(args["is_interactable"])

# GETTERS #
func get_is_interactable() -> bool:
	return is_interactable


# SETTERS #
func set_is_interactable(new):
	print("set_is_interactable")
	is_interactable = new
