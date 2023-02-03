extends Camera2D

var shake_timer = 0

# Called when the node enters the scene tree for the first time.
func shake(time):
	shake_timer = max(time, shake_timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shake_timer > 0:
		self.offset = Vector2(randf_range(-1, -1), randf_range(-1, 1))
	else:
		self.offset = Vector2.ZERO
	shake_timer -= 1
