extends CanvasLayer

var progress = []
var scene 
var scene_load_status = 0
@onready var progress_bar: PanelContainer = $Control/MarginContainer/HBoxContainer/PanelContainer
const progress_bar_max_size =650
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scene_load_status = ResourceLoader.load_threaded_get_status(scene,progress)
	var progress_tween= create_tween()
	progress_tween.set_trans(Tween.TRANS_QUAD)
	progress_tween.tween_property(progress_bar,"custom_minimum_size:x",progress[0]*650,0)
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var new_scene = ResourceLoader.load_threaded_get(scene)
		add_sibling(new_scene.instantiate())
		queue_free()
	

func load_scene(scene_to_load : String):
	scene=scene_to_load
	PROPERTY_USAGE_DEFERRED_SET_RESOURCE
	ResourceLoader.load_threaded_request(scene)
	
	
