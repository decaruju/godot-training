extends ItemList

var items = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func pickup_item(item):
	items.append(item)
	add_item("", ImageTexture.create_from_image(Image.load_from_file(item["sprite"])))
	
