extends Node2D

var max_health = 10.0;
var health = max_health;
var hurt_timer = 0;

func _ready():
	queue_redraw()
	
func _physics_process(delta):
	hurt_timer -= 1
	


func _draw():
	draw_rect(Rect2(-8, -16, 16, 4), Color.BLACK)
	draw_rect(Rect2(-7, -15, health/max_health*14, 2), Color.GREEN)

func hurt(damage, attacker):
	if hurt_timer > 0:
		return
	# KNOCKBACK
	get_node("/root/Root/Camera").shake(10)
	health -= damage
	hurt_timer = 5
	get_parent().on_hurt(attacker)
	queue_redraw()
	if health <= 0:
		get_parent().die()
