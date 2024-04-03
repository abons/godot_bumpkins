extends CharacterBody2D

const SPEED = 800.0
#@export var speed = 400
var target = position
var active = false

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()
#	velocity.x = direction.x * SPEED * delta
#	velocity.y = direction.y * SPEED * delta
	velocity = position.direction_to(target) * SPEED
	# look_at(target)
	if position.distance_to(target) > 10:
		move_and_slide()

func _input(event):
	if event is InputEventMouseButton && event.is_pressed():
		if event.position.distance_to(position) < 50:
			# unit active
			active = !active
			$Sprite2D.get_material().set_shader_parameter('active',active)
		if active:
			target = get_global_mouse_position()
