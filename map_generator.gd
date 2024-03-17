extends Node2D

enum TerrainType { PLAIN, FOREST, WATER, MOUNTAIN }
var map_size = Vector2(400, 400) # Adjust map size as needed
var terrain_grid = []
var noise = FastNoiseLite.new()

func _ready():
	noise.seed = randi() # Random seed for each run, or use a specific number for consistency
	noise.noise_type = 3 #perlin
	noise.fractal_type =1
	noise.fractal_octaves =5
	noise.fractal_lacunarity =2.0
	noise.fractal_gain =0.5
	noise.frequency =0.03
	generate_map()
	queue_redraw()

func generate_map():
	for x in range(int(map_size.x)):
		var column = []
		for y in range(int(map_size.y)):
			var value = noise.get_noise_2d(x,y)
			column.append(determine_terrain(value))
		terrain_grid.append(column)
	# Here you would draw the map or create tiles based on terrain_grid

func determine_terrain(value):
	if value < -0.2:
		return TerrainType.WATER
	elif value < 0:
		return TerrainType.PLAIN
	elif value < 0.1:
		return TerrainType.FOREST
	else:
		return TerrainType.MOUNTAIN

@onready var tile_map = $TileMap

func _draw():
	for x in range(int(map_size.x)):
		for y in range(int(map_size.y)):
			var terrain_type = terrain_grid[x][y]
			if terrain_type == TerrainType.PLAIN:
				tile_map.set_cell(0, Vector2(x, y), 13, Vector2i(8,5))
			elif terrain_type == TerrainType.FOREST:
				tile_map.set_cell(0, Vector2(x, y), 12, Vector2i(5,3))
			elif terrain_type == TerrainType.WATER:
				tile_map.set_cell(0, Vector2(x, y), 16, Vector2i(0,5))
			elif terrain_type == TerrainType.MOUNTAIN:
				tile_map.set_cell(0, Vector2(x, y), 15, Vector2i(3,1))
			#draw_rect(Rect2(pos, cell_size), COLOR_MOUNTAIN, true)
