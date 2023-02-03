extends Node2D

const MIN_ROOM_SIZE = 5
const MAX_ROOM_SIZE = 15
const MAX_ROOM_COORD = 50


@onready var enemyScene = preload("res://enemy.tscn")
@onready var torchScene = preload("res://torch.tscn")
var rooms = []
var enemies = []


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var player = get_node("/root/Root/Player")
	for i in range(3):
		var room = Rect2(
				randi_range(-MAX_ROOM_COORD, MAX_ROOM_COORD),
				randi_range(-MAX_ROOM_COORD, MAX_ROOM_COORD),
				randi_range(MIN_ROOM_SIZE, MAX_ROOM_SIZE),
				randi_range(MIN_ROOM_SIZE, MAX_ROOM_SIZE),
			)
		rooms.append(
			room
		)
		var enemy = enemyScene.instantiate()
		enemy.global_position = to_global($TileMap.map_to_local(room.get_center()))
		enemy.target = player
		add_child(enemy)
		enemies.append(enemy)
	var corridors = []
	for i in range(len(rooms) - 1):
		if rooms[i].intersects(rooms[i+1]):
			continue
		corridors.append(
			Rect2(
				int(min(rooms[i].get_center()[0], rooms[i+1].get_center()[0])),
				int(min(rooms[i].get_center()[1], rooms[i+1].get_center()[1])),
				ceil(abs(rooms[i].get_center()[0] - rooms[i+1].get_center()[0])),
				1,
			),
		)
		corridors.append(
			Rect2(
				int(min(rooms[i].get_center()[0], rooms[i+1].get_center()[0])),
				int(min(rooms[i].get_center()[1], rooms[i+1].get_center()[1])),
				1,
				ceil(abs(rooms[i].get_center()[1] - rooms[i+1].get_center()[1])),
			),
		)
	rooms += corridors
	for room in rooms:
		for tile in iter_rect(room):
			$TileMap.set_cell(0, tile, 0, Vector2i(3, 3))
			for direction in [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]:
				var wall = direction + tile
				if $TileMap.get_cell_tile_data(0, wall) == null:
					$TileMap.set_cell(0, wall, 0, Vector2i(16, 3))
	center_player(player)
	$DungeonExit.global_position = player.global_position + 32 * Vector2.RIGHT
		
func center_player(player):
	player.global_position = to_global($TileMap.map_to_local(rooms[0].get_center()))
	
func pairs(iterable):
	var rtn = []
	for i in range(len(iterable)):
		for j in range(i, len(iterable)):
			rtn.append([iterable[i], iterable[j]])
	return rtn
	
func iter_rect(rect):
	var rtn = []
	for x in range(rect.size[0]):
		for y in range(rect.size[1]):
			rtn.append(Vector2i(x+rect.position[0], y+rect.position[1]))
	return rtn
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
