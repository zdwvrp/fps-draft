extends Control

@onready var buttonOne := $Button
@onready var buttonTwo := $Button2
@onready var buttonThree := $Button3
@onready var buttonFour := $Button4

# Called when the node enters the scene tree for the first time.
func _ready():
	var pack = PackCreator.createPack()
	var buttons = [buttonOne, buttonTwo, buttonThree, buttonFour]
	for i in pack.size():
		# buttons[i].text = pack[i]["rarity"] + "\n" + pack[i]["name"]
		buttons[i].texture_normal = load(pack[i]["image"])
