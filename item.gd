class_name Item extends Game_Object

var item_id: int = 0 # What collection is this item from?
var collection_id: int = 0 # Id of this item in it's collection
var usid: String = ""

const item_id_collections_map: Array = ["null", "backpack"] # String representation of item_id

# Called when the node enters the scene tree for the first time.
func _init(args):
	# PUT LOG HERE
	set_item_id(args["item_id"])
	set_collection_id(args["collection_id"])
	set_usid(args["usid"])
	
	var game_object_properties = {}
	game_object_properties["is_interactable"] = args["is_interactable"] if args["is_interactable"] else false
	super(game_object_properties)


# GETTERS #
func get_item_id() -> int:
	return item_id
func get_collection_id() -> int:
	return collection_id
func get_usid() -> String:
	return usid


# SETTERS #
func set_item_id(new):
	print("set_item_id")
	item_id = new
func set_collection_id(new):
	print("set_collection_id")
	collection_id = new
func set_usid(new):
	print("set_usid")
	usid = new
