extends CharacterBody2D

const SPEED = 800.0

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()
	velocity.x = direction.x * SPEED * delta
	velocity.y = direction.y * SPEED * delta

	move_and_slide()
