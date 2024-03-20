extends Control

func _ready():
	var map_scene = get_tree().get_root().find_child("Map",true,false)
	if map_scene:
		var btn_continue = $MarginContainer/VBoxContainer/Continue
		btn_continue.show()

func _on_text_edit_ready():
	var seedvalue = $MarginContainer/VBoxContainer/TextEdit
	seedvalue.set_text(str(randi()))

func _on_button_pressed():
	# Remove old map
	var map_scene = get_tree().get_root().find_child("Map",true,false)
	if map_scene:
		get_tree().get_root().remove_child(map_scene)
	# We instantiate the scene before we add it 
	map_scene = load("res://content/map.tscn").instantiate();
	# parameterize the scene
	var seedvalue = $MarginContainer/VBoxContainer/TextEdit
	map_scene.seedvalue = int(seedvalue.get_text())
	# Add the scene as a child to the sceneTree
	get_tree().get_root().add_child(map_scene)
	# Remove menu
	var menu_scene = get_tree().get_root().find_child("Menu",true,false)
	get_tree().get_root().remove_child(menu_scene)

func _on_continue_pressed():
	var menu_scene = get_tree().get_root().find_child("Menu",true,false)
	get_tree().get_root().remove_child(menu_scene)
