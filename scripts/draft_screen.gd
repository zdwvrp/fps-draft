extends Control

# Scene definitions
@onready var card := preload("res://scenes/cardButton.tscn")

# Node definitions
@onready var vbox = $CardSection/MarginContainer/VBoxContainer
@onready var hbox = $CardSection/MarginContainer/VBoxContainer/HBoxContainer

# Variable definitions
var maxCardsPerRow: int = 4

# @onready var buttonOneTextureRect := $CardSection/MarginContainer/VBoxContainer/HBoxContainer/Button5/TextureRect
# @onready var buttonTwoTextureRect := $CardSection/MarginContainer/VBoxContainer/HBoxContainer/Button6/TextureRect
# @onready var buttonThreeTextureRect := $CardSection/MarginContainer/VBoxContainer/HBoxContainer/Button7/TextureRect
# @onready var buttonFourTextureRect := $CardSection/MarginContainer/VBoxContainer/HBoxContainer/Button8/TextureRect
# @onready var buttonFiveTextureRect := $CardSection/MarginContainer/VBoxContainer/HBoxContainer/Button9/TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	# Generate pack
	var containsMythic = randi_range(1,8)
	var pack = PackCreator.createPack(10, 3, 0, 1) if containsMythic == 8 else PackCreator.createPack(10, 3, 1, 0)
	#var buttons = [
		#buttonOneTextureRect,
		#buttonTwoTextureRect,
		#buttonThreeTextureRect,
		#buttonFourTextureRect,
		#buttonFiveTextureRect
	#]
	
	# Populate ui elements with cards
	var current_hbox = hbox # Working hbox variable for this loop. Defaults to the original hbox
	
	print("number of cards: ", pack.size())
	
	for i in pack.size():
		# Add a new hbox after every 4th card
		if i > 0 and i % 4 == 0:
			
			# Clone original hbox & remove all child nodes
			var new_hbox = hbox.duplicate()
			for j in new_hbox.get_children():
				j.queue_free()
			
			# Set working hbox variable to the new one
			current_hbox = new_hbox
			
			# Add new hbox to scene as a child of the vbox
			vbox.add_child(new_hbox) 
			
		# Create a new button node
		var newButton = card.instantiate()
		var newButtonTextureRect: TextureRect = newButton.get_node("TextureRect")
		
		# Set node properties
		newButton.text = pack[i]["rarity"] + "\n" + pack[i]["name"]
		newButtonTextureRect.texture = load(pack[i]["image"])
		
		# Add a button to the current working hbox
		current_hbox.add_child(newButton)



# WIP 3/30/26:
#	- Convert texture buttons to buttons with texturerect child components.
#	- Make rest of layout, add more cards to fill it out & add them in here.
#	- BONUS: Get more card images to use for testing.

#	- Setup Equipment Section
#	- Think destiny-style loadout screen w/ card hovering.
