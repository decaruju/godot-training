extends Node2D

@onready var enemyScene = preload("res://enemy.tscn")
@export var target: Node2D
const DELAY = 100
var spawn_timer = DELAY;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn_timer -= 1
	if spawn_timer < 0:
		spawn_timer = DELAY
		var enemy = enemyScene.instantiate()
		enemy.target = target
		self.get_parent().add_child(enemy)
