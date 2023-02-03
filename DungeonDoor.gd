extends Area2D

var last_position = position
var dungeon: Node2D = null

func _process(delta):
	for body in get_overlapping_bodies():
		if body.name == "Player":
			dungeon = get_node("/root/Root/World").open_dungeon(global_position, dungeon)
		
