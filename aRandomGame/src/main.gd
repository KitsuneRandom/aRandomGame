extends Node

# La scène main sert de scène de base dès le démarrage du jeu.
# Elle lancera d'abord une scène main_menu puis gèrera le changement vers the_game
@onready var game : PackedScene = preload("res://scenes/game/the_game.tscn")

func _ready() -> void:
	# à déplacer plus tard ⬇️
	var game_instance = game.instantiate()
	add_child(game_instance)
