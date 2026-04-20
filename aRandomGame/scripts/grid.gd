extends Node2D


@onready var visual_tile_map: TileMap = $VisualTileMap
@onready var background: TileMapLayer = $Background
@onready var over: TileMapLayer = $Over

# Association des coordonnées dans le tileset "grid" à leurs noms de types de terrains 
const tile_type : Dictionary = {
	Vector2i(0,0) : "Path",
	Vector2i(1,0) : "Grass",
	Vector2i(2,0) : "Water",
	Vector2i(3,0) : "Dirt",
	Vector2i(4,0) : "Sand"
}
#Association de la forme de la tile avec sa coordonnées dans le tileset "texture"
# [0][1]
# [2][3]
# où 0 = vide et 1 = plein
const tile_shape : Dictionary = {
	[0,0,1,0]: Vector2i(0,0),
	[0,1,0,1]: Vector2i(1,0),
	[1,0,1,1]: Vector2i(2,0),
	[0,0,1,1]: Vector2i(3,0),
	[1,0,0,1]: Vector2i(0,1),
	[0,1,1,1]: Vector2i(1,1),
	[1,1,1,1]: Vector2i(2,1),
	[1,1,1,0]: Vector2i(3,1),
	[0,1,0,0]: Vector2i(0,2),
	[1,1,0,0]: Vector2i(1,2),
	[1,1,0,1]: Vector2i(2,2),
	[1,0,1,0]: Vector2i(3,2),
	# pas de Vector2i(3,0) c'est une case vide
	[0,0,0,1]: Vector2i(1,3),
	[0,1,1,0]: Vector2i(2,3),
	[1,0,0,0]: Vector2i(3,3)
}

#Association des noms des types de terrains avec leurs sources dans "texture"
const tile_origin : Dictionary ={
	"Path" : 1,
	"Sand" : 2,
	"Water" : 3
}

func set_visual_layers(tilemap : TileMapLayer,limite1 : Vector2i , limite2 : Vector2i):
	var tile : Vector2i = limite1	
	while tile.x<=limite2.x:
		tile.y=limite1.y
		while tile.y<=limite2.y:
			set_tile(tilemap,tile)
			tile.y+=1
		tile.x+=1

func set_tile(tilemap : TileMapLayer,tile_coord : Vector2i):
	var num_layer : int = 0
	if tilemap!=background:
		num_layer+=1
	
	var neighbours=get_neighbours(tilemap,tile_coord)
	var sorted_neighbours : Dictionary =sort_neighbour(neighbours)
	
	for n in sorted_neighbours:
		var active_layer : TileMapLayer = visual_tile_map.get_child(num_layer)
		active_layer.set_cell(tile_coord,tile_origin.get(n,1),tile_shape.get(sorted_neighbours.get(n)))
		num_layer+=1

func get_neighbours(tilemap : TileMapLayer,tile_coord : Vector2i) -> Array[String]:
	var neighbour : Array[String]=[]
	for y in range(2):
		for x in range(2):
			print(tile_type.get(tilemap.get_cell_atlas_coords(tile_coord+Vector2i(x,y))))
			neighbour.insert(x+y*2,tile_type.get(tilemap.get_cell_atlas_coords(tile_coord+Vector2i(x,y)),"Null")) 
	return neighbour
	
func sort_neighbour(neighbours : Array[String]) -> Dictionary:
	var sorted : Dictionary
	for n in range(4):
		if neighbours[n]== "Null":
			continue
		sorted.get_or_add(neighbours[n],[0,0,0,0])[n]=1
	return sorted

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.visible=false
	over.visible=false
	load_zone(Vector2(-400,-250),Vector2(400,250))

func load_zone(limite_coord1 : Vector2, limite_coord2 : Vector2):
	var limite1 : Vector2i = limite_coord1/32
	var limite2 : Vector2i = limite_coord2/32
	set_visual_layers(background,limite1,limite2)
	set_visual_layers(over,limite1,limite2)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
