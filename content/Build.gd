extends Node2D

var radius = 100  # Radius of the circular menu

func _ready():
	# Get the screen center
	var screen_center = get_viewport_rect().size * 0.5
	# Find all TextureButtons added to the group "circular_menu"
	var buttons = get_children()
	var num_buttons = buttons.size()
	
	var angle_step = 2 * PI / num_buttons  # Calculate the angle between each button
	
	for i in range(num_buttons):
		var angle = i * angle_step
		var x = cos(angle) * radius
		var y = sin(angle) * radius
		
		# Calculate the position for each button
		var position = screen_center + Vector2(x, y)
		
		# Set the position of each button
		buttons[i].position = position
