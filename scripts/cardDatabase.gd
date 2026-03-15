#yo zach, this bad boy sorts a bunch of cards from our JSON file into arrays based on rarity.
#will be useful when making the pack opening experience because we dont want every card to be a rare obviously, lets us set this up like a magic pack (1 rare/mythic, 4 uncs, 10 com for example)
#brother i haven't written code since high school this took ages and a lot of reading and googling
#next on the list is a pack generator script using these arrays but losing steam here so that comes tomo

extends Node

#bunch o' arrays
var cards = []
var commons = []
var uncommons = []
var rares = []
var mythics = []

#thing that runs the functions
func _ready():
	loadCards()
	sortCards()

#loads all the cards from the JSON file
func loadCards():
	var file = FileAccess.open("res://data/cardData.json", FileAccess.READ)
	cards = JSON.parse_string(file.get_as_text())

#sorts the cards into that group o' arrays
func sortCards():
	for card in cards:
		match card.rarity:
			"common":
				commons.append(card)
			"uncommon":
				uncommons.append(card)
			"rare":
				rares.append(card)
			"mythic":
				mythics.append(card)
