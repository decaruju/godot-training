extends TileMap

const CELL_TYPES = {
	"grass": [
		[0, 1, 2, 3],
		[0, 1, 2, 3],
	]
}

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(10):
		for j in range(10):
			populate_cell(i, j)

func populate_cell(x, y):
	for item in enumerate(CELL_TYPES[cell_type(x, y)]):
		var layer = item[0]
		var tiles = item[1]
		var cell = tiles[randi() % len(tiles)]
		set_cell(layer, Vector2(x, y), 0, Vector2(cell, layer))

func cell_type(x, y):
	return "grass"

func enumerate(iterable):
	var rtn = []
	var i = 0
	for item in iterable:
		rtn.append([i, item])
		i += 1
	return rtn
		
