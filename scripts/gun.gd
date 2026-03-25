extends Item

class_name Gun

# Parent Properties
# var id: int = 0
# var usid: String = "gun_0"

# Class Properties
var magazine_size: int = 30

const gun_map = [
	{
		"item_id": 1,
		"collection_id": 0,
		"usid": "Placeholder Gun",
		"magazine_size": 1,
	},
	{
		"item_id": 1,
		"collection_id": 1,
		"usid": "First Weapon that shoots bang bang",
		"magazine_size": 6,
	},
	{
		"item_id": 1,
		"collection_id": 2,
		"usid": "School Pack",
		"magazine_size": 30
	}
]

# Called when an instance of this class is initialized.
# Invoke with Gun.new(params)
func _init(id: int = 1):
	print("Init gun!")
	var new_gun_properties = gun_map[id]
	var super_properties = {
		"is_interactable": true,
		"item_id": new_gun_properties["item_id"],
		"collection_id": new_gun_properties["collection_id"],
		"usid": new_gun_properties["usid"]
	}
	
	if !new_gun_properties:
		print("[ERROR] Gun not found...")
		new_gun_properties = gun_map[0]
	
	# Instantiate properties
	super(super_properties)
	set_magazine_size(new_gun_properties["magazine_size"])
	


# GETTERS #
func get_magazine_size() -> int:
	return magazine_size


# SETTERS #
func set_magazine_size(new):
	print("set_magazine_size")
	magazine_size = new
