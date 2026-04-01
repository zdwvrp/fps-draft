class_name packCreator extends Node

#here just for testing purposes
func _ready():
	createPack()

#this needs to be tweaked obviously, but it works
#also figured out why testing wasnt working, scripts must be attached to nodes to work with the "output" tab below, so i made a test node

func createPack(commons: int = 1, uncommons: int = 1, rares: int = 1, mythics: int = 1):
	
	#new variable "pack" is the final array before showing the player what they got
	var pack = []
	
	#shuffle the arrays with all the cards (sorted by rarity) from the JSON file
	CardDatabase.commons.shuffle()
	CardDatabase.uncommons.shuffle()
	CardDatabase.rares.shuffle()
	CardDatabase.mythics.shuffle()
	
	#takes the first selection from each rarity array puts it into the new "pack" array
	for i in commons:
		pack += CardDatabase.commons.slice(i, i + 1)
	for i in uncommons:
		pack += CardDatabase.uncommons.slice(i, i + 1)
	for i in rares:
		pack += CardDatabase.rares.slice(i, i + 1)
	for i in mythics:
		pack += CardDatabase.mythics.slice(i, i + 1)
	
	#prints pack array, just for testing currently?
	return pack
