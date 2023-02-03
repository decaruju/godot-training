extends Area2D

func _process(delta):
	for body in get_overlapping_bodies():
		if body.name == "Player":
			get_node("/root/Root/World").leave_dungeon()
		
