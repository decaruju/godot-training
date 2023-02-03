extends Area2D

@export var descriptor: Dictionary

func _ready():
	$Sprite2D.texture = ImageTexture.create_from_image(Image.load_from_file(descriptor["sprite"]))

func _process(delta):
	for body in get_overlapping_bodies():
		if body.name == "Player":
			get_node("/root/Root/HUD/Inventory").pickup_item(self.descriptor)
			queue_free()
