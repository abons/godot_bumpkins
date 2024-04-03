extends Node2D

enum TerrainType { WATER,SAND,PLAIN,FOREST,MOUNTAIN }
var map_size = Vector2(150, 100) # Adjust map size as needed
var noise = FastNoiseLite.new()
var seedvalue = randi()
var Build_scene = null

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_ESCAPE:
				var menu_scene = load("res://scenes/Menu.tscn").instantiate();
				get_tree().get_root().add_child(menu_scene)
			if event.keycode == KEY_Q:
				get_tree().quit()
			if event.keycode == KEY_R:
				seedvalue = randi()
				init()

func _ready():
	init()
	call_deferred("_build")
	
func _build():
	print(get_tree().get_root().get_children())
	Build_scene = load("res://scenes/Build.tscn").instantiate();
	get_tree().get_root().add_child(Build_scene)
	var Unit_scene = load("res://scenes/Unit.tscn").instantiate();
	get_tree().get_root().add_child(Unit_scene)

func _exit_tree():
	if Build_scene != null:
		get_tree().get_root().remove_child(Build_scene)
	
func init():
	noise.seed = seedvalue
	noise.noise_type = 3 #perlin
	noise.fractal_type =1
	noise.fractal_octaves =5
	noise.fractal_lacunarity =2.0
	noise.fractal_gain =0.5
	noise.frequency =0.03
	TerrainData.terrain_values = []
	queue_redraw()

func determine_terrain(value):
	if value < -0.2:
		return TerrainType.WATER
	elif value < -0.14:
		return TerrainType.SAND
	elif value < 0.2:
		return TerrainType.PLAIN
	#elif value < 0.15:
	#	return TerrainType.FOREST
	elif value < 0.20:
		return TerrainType.PLAIN
	else:
		return TerrainType.PLAIN#MOUNTAIN

@onready var tile_map = $TileMap

func _draw():
	tile_map.clear()
	var cell_size = Vector2(64,64)
	for x in range(int(map_size.x)):
		var column = []
		for y in range(int(map_size.y)):
			var value = noise.get_noise_2d(x,y)
			var terrain_type = determine_terrain(value)
			column.append(terrain_type)
			var pos = Vector2(x * cell_size.x, y * cell_size.y)
			if terrain_type == TerrainType.WATER:
				#draw_rect(Rect2(pos, cell_size), Color(0.0, 0.0, 0.5), true)
				#tile_map.set_cell(0, Vector2(x, y), 16, Vector2i(0,5))
				tile_map.set_cell(0, Vector2(x, y), 5, Vector2i(x%15,y%15))
			elif terrain_type == TerrainType.SAND:
				#draw_rect(Rect2(pos, cell_size), Color(0.9, 0.8, 0.6), true)
				tile_map.set_cell(0, Vector2(x, y), 4, Vector2i(x%15,y%15))
			elif terrain_type == TerrainType.PLAIN:
				#draw_rect(Rect2(pos, cell_size), Color(0.9, 0.8, 0.6), true)
				tile_map.set_cell(0, Vector2(x, y), 1, Vector2i(x%15,y%15))
			elif terrain_type == TerrainType.FOREST:
				draw_rect(Rect2(pos, cell_size), Color(0.4, 0.9, 0.4), true)
				#tile_map.set_cell(0, Vector2(x, y), 12, Vector2i(5,3))
			elif terrain_type == TerrainType.MOUNTAIN:
				#tile_map.set_cell(0, Vector2(x, y), 15, Vector2i(3,1))
				draw_rect(Rect2(pos, cell_size), Color(0.5, 0.5, 0.5), true)
		TerrainData.terrain_values.append(column)
		#TerrainData.terrain_values[x][y]
		#print(column)
