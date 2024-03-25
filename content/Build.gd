extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Het pad naar de scene van het huis
var house_scene_path = "res://scenes/BuildHouse.tscn"
func _on_house_pressed():
	# Laad de huis scene
	var house_scene = load(house_scene_path).instantiate()
	# Voeg het huis toe aan de hoofdscene of een specifieke node binnen die scene
	get_tree().get_root().add_child(house_scene)
