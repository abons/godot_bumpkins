extends Sprite2D # Of een ander node type afhankelijk van jouw setup

var dragging = true
var start = true

func _ready():
	# Zorg ervoor dat input events doorgestuurd worden naar de script
	set_process_input(true)

func _input(event):
	if start:
		start = false
		position = event.position
	elif event is InputEventMouseButton && event.is_pressed():
		if event.position.distance_to(position) < 50:
			# Begin met slepen als er op het huis geklikt wordt
			dragging = !dragging
	elif event is InputEventMouseMotion and dragging:
		# Verplaats het huis als er gesleept wordt
		position += event.relative
