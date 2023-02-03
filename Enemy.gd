extends CharacterBody2D

const SPEED = 32
const FULL_ATTACK_TIMER = 100
var attack_timer = FULL_ATTACK_TIMER
@export var target: Node2D
@export var item = preload("res://item.tscn")


func on_hurt(attacker):
	velocity = (position - attacker.position).normalized() * 200
	$AnimatedSprite2D.flash(5)

func _physics_process(delta):
	if target == null:
		return
		
	var position_delta = (target.position - position)
	if $Health.hurt_timer < 0:
		velocity = position_delta.normalized() * SPEED
	else:
		velocity *= 0.95

	move_and_slide()
	chose_animation(position_delta)
	
	attack_timer -= 1
	if position_delta.length() < SPEED and attack_timer < 0:
		attack_timer = FULL_ATTACK_TIMER
		$Equipment/Weapon/AnimationPlayer.play("slash")
		
func die():
	var item_instance = item.instantiate()
	item_instance.descriptor = {"sprite": "res://blade.png", "name": "Blade"}
	item_instance.global_position = global_position
	get_parent().add_child(item_instance)
	queue_free()
	

func chose_animation(position_delta):
	var animated_sprite = $AnimatedSprite2D
	if position_delta.length() == 0:
		animated_sprite.frame = 1
		animated_sprite.playing = false
	else:
		$Equipment.rotation = atan2(-position_delta.x, position_delta.y)
		if animated_sprite.playing == false:
			animated_sprite.frame = 0
		animated_sprite.playing = true
		if abs(position_delta.x) > abs(position_delta.y):
			animated_sprite.animation = "PlayerRight" if position_delta.x > 0 else "PlayerLeft"
		else:
			animated_sprite.animation = "PlayerDown" if position_delta.y > 0 else "PlayerUp"
