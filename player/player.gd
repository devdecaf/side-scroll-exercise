extends CharacterBody2D

### stats
var speed = 40000
var jumpstrength = -1400
var grav = 80000

@onready var _animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D


func _physics_process(delta: float) -> void:
	var movedir = Input.get_axis("left","right")
	if is_on_floor():
		velocity.y = 0
		if Input.is_action_just_pressed("jump"):
			velocity.y = jumpstrength
		if movedir:
			velocity.x = lerpf(velocity.x,movedir * speed * delta,0.1)
		else:
			velocity.x = lerpf(velocity.x,0,0.1)
	else:
		velocity.y = lerpf(velocity.y,grav * delta,0.03)
		if movedir:
			velocity.x = lerpf(velocity.x,movedir * speed * delta,0.1)
		else:
			velocity.x = lerpf(velocity.x,0,0.01)
	
	# player animations based on movement
	_animated_sprite_2d.flip_h = velocity.x < 0.0
	if velocity.y != 0.0:
		_animated_sprite_2d.pause()
	elif absf(velocity.x) > 20.0:
		_animated_sprite_2d.play("walk")
	elif absf(velocity.x) <= 20.0:
		_animated_sprite_2d.play("idle")
	
	move_and_slide()
