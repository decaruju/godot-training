extends AnimatedSprite2D

var flash_frames = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flash_frames > 0:
		self.modulate = Color(10, 10, 10, 10)
	else:
		self.modulate = Color(1, 1, 1, 1)
	flash_frames -= 1

func flash(frames):
	flash_frames = max(flash_frames, frames)
	
