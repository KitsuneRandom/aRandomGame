extends Control

@onready var loading_screen : PackedScene = preload("res://scenes/menus/load_screen/loading_screen.tscn")

func _ready() -> void:
	pass


func _on_btn_continue_pressed() -> void:
	pass # Replace with function body.




func _on_btn_new_pressed() -> void:
	var load_instance = loading_screen.instantiate()
	get_parent().add_child(load_instance)
	load_instance.load_scene("res://scenes/game/the_game.tscn")
	queue_free()

func _on_btn_params_pressed() -> void:
	pass # Replace with function body.


func _on_btn_credit_pressed() -> void:
	pass # Replace with function body.


func _on_btn_quit_pressed() -> void:
	get_tree().quit()
