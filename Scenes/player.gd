extends CharacterBody2D

const SPEED = 300.0

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	var rightGunDirection = Input.get_vector("Right_Gun_Left", "Right_Gun_Right", "Right_Gun_Up", "Right_Gun_Down")
	var leftGunDirection = Input.get_vector("Left_Gun_Left", "Left_Gun_Right", "Left_Gun_Up", "Left_Gun_Down")
	var rotate_left = Input.get_action_strength("Rotate_Left")
	var rotate_right = Input.get_action_strength("Rotate_Right")
	var ship_rotation = $Ship.rotation if $Ship.rotation > 0 else 0 
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if( rotate_right > 0 ):
		$Ship.rotation_degrees += 2
	if( rotate_left > 0 ):
		$Ship.rotation_degrees -= 2
	
	if rightGunDirection != Vector2.ZERO:
		var angle = rightGunDirection.angle()
		$Ship/RightGun.global_rotation = angle
	
	if leftGunDirection != Vector2.ZERO:
		$Ship/LeftGun.flip_h = true
		var angle = leftGunDirection.angle()
		$Ship/LeftGun.global_rotation = angle
	
	move_and_slide()
