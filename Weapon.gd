extends Area2D

var last_position = position

func _process(delta):
	for body in get_overlapping_bodies():
		if body.has_node("Health"):
			var parent = get_parent()
			var damage = 0
			if parent.has_method("damage"):
				damage = parent.damage()
			else:
				damage = (position - last_position).length()
			body.get_node("Health").hurt(damage, self)
			
			if parent.has_method("on_attack"):
				parent.on_attack()
	last_position = position
		
