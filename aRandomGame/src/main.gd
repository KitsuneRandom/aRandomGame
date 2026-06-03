extends Node

# La scène main sert de scène de base dès le démarrage du jeu.
# Elle lancera d'abord une scène main_menu puis gèrera le changement vers the_game
@onready var loading_screen : PackedScene = preload("res://scenes/menus/load_screen/loading_screen.tscn")

func _ready() -> void:
	var load_instance = loading_screen.instantiate()
	add_child(load_instance)
	load_instance.load_scene("res://scenes/menus/main_menu/home_menu.tscn")
