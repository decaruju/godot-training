extends Node2D

@onready var dungeonScene = preload("res://dungeon.tscn")
@onready var overworld = $Overworld
@onready var player = get_node("%Player")
@onready var entrance_coordinate: Vector2
var current_dungeon: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func open_dungeon(entrance_coordinate, dungeon):
	entrance_coordinate = entrance_coordinate
	if dungeon == null:
		dungeon = dungeonScene.instantiate()
	remove_child(overworld)
	add_child(dungeon)
	current_dungeon = dungeon
	dungeon.center_player(player)
	return dungeon

func leave_dungeon():
	remove_child(current_dungeon)
	current_dungeon = null
	add_child(overworld)
	player.global_position = entrance_coordinate + Vector2.RIGHT*32
	
