extends CharacterBody2D

### stats
var speed = 40000
var jumpstrength = -4000
var grav = 80000



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
		velocity.y = lerpf(velocity.y,grav * delta,0.1)
		if movedir:
			velocity.x = lerpf(velocity.x,movedir * speed * delta,0.1)
		else:
			velocity.x = lerpf(velocity.x,0,0.01)
	move_and_slide()
