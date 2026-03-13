extends Item

class_name Backpack

# Parent Properties
# var id: int = 0
# var usid: String = "backpack_0"

# Class Properties
var hotbar_slots: int = 0
var hotbar_slot_map: Array = []
var max_storage: float = 0.0
var min_storage: float = 0.0 # Why not
var backpack_class: String = ""
var stability: String = ""
var flexibility: String = ""
var quality: String = ""
var comfortability: String = ""
var has_quick_access_loop: bool = false
var has_backpack_straps: bool = true # Something
var waterproof_level: int = 0

const backpack_map = [
	{
		"item_id": 1,
		"collection_id": 0,
		"usid": "Placeholder Backpack"
	},
	{
		"item_id": 1,
		"collection_id": 1,
		"usid": "Default Pack",
		"hotbar_slots": 4,
		"hotbar_slot_map": [],
		"max_storage": 40.0,
		"min_storage": 0.0,
		"backpack_class": "medium",
		"stability": "medium",
		"flexibility": "medium",
		"quality": "medium",
		"comfortability": "medium",
		"has_quick_access_loop": false,
		"has_backpack_straps": true,
		"waterproof_level": 1
	},
	{
		"item_id": 1,
		"collection_id": 2,
		"usid": "School Pack",
		"hotbar_slots": 4,
		"hotbar_slot_map": [],
		"max_storage": 35.0,
		"min_storage": 0.0,
		"backpack_class": "small",
		"stability": "low",
		"flexibility": "high",
		"quality": "medium",
		"comfortability": "low",
		"has_quick_access_loop": true,
		"has_backpack_straps": true,
		"waterproof_level": 2
	}
]

# Called when an instance of this class is initialized.
# Invoke with Backpack.new(params)
func _init(id):
	print("Init backpack!")
	var new_backpack_properties = backpack_map[id]
	var super_properties = {
		"is_interactable": true,
		"item_id": new_backpack_properties["item_id"],
		"collection_id": new_backpack_properties["collection_id"],
		"usid": new_backpack_properties["usid"]
	}
	
	if !new_backpack_properties:
		print("[ERROR] Backpack not found...")
		new_backpack_properties = backpack_map[0]
	
	# Instantiate properties
	super(super_properties)
	set_hotbar_slots(new_backpack_properties["hotbar_slots"])
	set_hotbar_slot_map(new_backpack_properties["hotbar_slot_map"])
	set_max_storage(new_backpack_properties["max_storage"])
	set_min_storage(new_backpack_properties["min_storage"])
	set_backpack_class(new_backpack_properties["backpack_class"])
	set_stability(new_backpack_properties["stability"])
	set_flexibility(new_backpack_properties["flexibility"])
	set_quality(new_backpack_properties["quality"])
	set_comfortability(new_backpack_properties["comfortability"])
	set_has_quick_access_loop(new_backpack_properties["has_quick_access_loop"])
	set_has_backpack_straps(new_backpack_properties["has_backpack_straps"])
	set_waterproof_level(new_backpack_properties["waterproof_level"])
	


# GETTERS #
func get_hotbar_slots() -> int:
	return hotbar_slots
func get_hotbar_slot_map() -> Array:
	return hotbar_slot_map
func get_max_storage() -> float:
	return max_storage
func get_min_storage() -> float:
	return min_storage
func get_backpack_class() -> String:
	return backpack_class
func get_stability() -> String:
	return stability
func get_flexibility() -> String:
	return flexibility
func get_quality() -> String:
	return quality
func get_comfortability() -> String:
	return comfortability
func get_has_quick_access_loop() -> bool:
	return has_quick_access_loop
func get_has_backpack_straps() -> bool:
	return has_backpack_straps
func get_waterproof_level() -> bool:
	return waterproof_level


# SETTERS #
func set_hotbar_slots(new):
	print("set_hotbar_slots")
	hotbar_slots = new
func set_hotbar_slot_map(new):
	# Come back to this
	print("set_hotbar_slot_map")
	hotbar_slot_map = new
func set_max_storage(new):
	print("set_max_storage")
	max_storage = new
func set_min_storage(new):
	print("set_min_storage")
	min_storage = new
func set_backpack_class(new):
	print("set_backpack_class")
	backpack_class = new
func set_stability(new):
	print("set_stability")
	stability = new
func set_flexibility(new):
	print("set_flexibility")
	flexibility = new
func set_quality(new):
	print("set_quality")
	quality = new
func set_comfortability(new):
	print("set_comfortability")
	comfortability = new
func set_has_quick_access_loop(new):
	print("set_has_quick_access_loop")
	has_quick_access_loop = new
func set_has_backpack_straps(new):
	print("set_has_backpack_straps")
	has_backpack_straps = new
func set_waterproof_level(new):
	print("set_waterproof_level")
	waterproof_level = new
