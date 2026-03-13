extends Node

# const Backpack = preload("res://backpack.gd")


var object = null
var collection_id = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	object = Backpack.new(collection_id)
	print("Instantiated backpack_game_object with collection_id = ", collection_id)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_collection_id() -> int:
	return collection_id
