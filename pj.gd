extends CharacterBody2D

var left = false
var right = true

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	
	if not is_on_floor():
		velocity.y += gravity * delta
		if left == true:
			$AnimatedSprite2D.play("jump_left")
		if right == true:
			$AnimatedSprite2D.play("jump_right")
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
			
	if Input.is_action_just_pressed("left"):
		$AnimatedSprite2D.play("walk_left")
		left = true
		right = false
	if Input.is_action_just_pressed("right"):
		$AnimatedSprite2D.play("walk_right")
		left = false
		right = true
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right") 
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if left == true:
			$AnimatedSprite2D.play("idle_left")
		if right == true:
			$AnimatedSprite2D.play("idle_right")
	move_and_slide()
