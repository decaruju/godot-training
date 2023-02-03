extends CharacterBody2D

const SPEED = 64
var attacks = [
	{'type': 'animation', 'animation_name': 'slash'},
	{'type': 'animation', 'animation_name': 'stab'},
	{'type': 'animation', 'animation_name': 'boomerang'},
	{'type': 'projectile', 'projectile': preload('res://fireball.tscn')},
]
var attack_index = 0
var direction = Vector2.DOWN

func _physics_process(delta):

	var horizontal = Input.get_axis("ui_left", "ui_right")
	var vertical = Input.get_axis("ui_up", "ui_down")
	
	if horizontal:
		velocity.x = horizontal * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if vertical:
		velocity.y = vertical * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	chose_animation()
	move_and_slide()
	
	if Input.is_action_just_pressed("change_attack"):
		attack_index += 1
	
	if Input.is_action_just_pressed("attack"):
		var attack = attacks[attack_index % len(attacks)]
		if attack['type'] == 'animation':
			$Equipment/Weapon/AnimationPlayer.play(attack['animation_name'])
		elif attack['type'] == 'projectile':
			var projectile = attack['projectile'].instantiate()
			get_parent().add_child(projectile)
			projectile.global_position = global_position
			projectile.position += direction * 20
			projectile.linear_velocity = direction * 50
		
func die():
	get_node("%World").leave_dungeon()


func on_hurt(attacker):
	$AnimatedSprite2D.flash(5)

func chose_animation():
	var animated_sprite = $AnimatedSprite2D
	if velocity.length() == 0:
		animated_sprite.frame = 1
		animated_sprite.playing = false
	else:
		$Equipment.rotation = atan2(-velocity.x, velocity.y)
		if animated_sprite.playing == false:
			animated_sprite.frame = 0
		animated_sprite.playing = true
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				direction = Vector2.RIGHT
				animated_sprite.animation = "PlayerRight"
			else:
				direction = Vector2.LEFT
				animated_sprite.animation = "PlayerLeft"
		else:
			if velocity.y > 0:
				direction = Vector2.DOWN
				animated_sprite.animation = "PlayerDown"
			else:
				direction = Vector2.UP
				animated_sprite.animation = "PlayerUp"
