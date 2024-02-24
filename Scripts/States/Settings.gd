extends Node2D

func _ready():
	print("Settings page ready!")
	
	var loaded_data = Saves.Load()
	if not loaded_data == null:
		if loaded_data["webhook_avatar"] != "default":
			$CanvasLayer/Control/Avatar/AvatarBox.text = loaded_data["webhook_avatar"]
		
		if loaded_data["webhook_name"] != "default":
			$CanvasLayer/Control/Name/NameBox.text = loaded_data["webhook_name"]
		
		$CanvasLayer/Control/URL/URLBox.text = loaded_data["webhook_url"]
		$CanvasLayer/Control/YourName/YourNameBox.text = loaded_data["user_name"]

func _on_apply_pressed():
	var webhook_avatar = $CanvasLayer/Control/Avatar/AvatarBox.text
	var webhook_name = $CanvasLayer/Control/Name/NameBox.text
	
	if webhook_avatar.is_empty():
		print("Using default avatar.")
		webhook_avatar = "default"
	
	if webhook_name.is_empty():
		print("Using default name.")
		webhook_name = "default"
	
	Saves.Save(
		$CanvasLayer/Control/YourName/YourNameBox.text, 
		webhook_name, 
		$CanvasLayer/Control/URL/URLBox.text, 
		webhook_avatar
	)


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/States/Main.tscn")


func _on_delete_save_pressed():
	$CanvasLayer/Control/Avatar/AvatarBox.text = ""
	$CanvasLayer/Control/Name/NameBox.text = ""
	$CanvasLayer/Control/YourName/YourNameBox.text = ""
	$CanvasLayer/Control/URL/URLBox.text = ""
	
	if not FileAccess.file_exists("user://data.save"):
		return
	
	DirAccess.remove_absolute("user://data.save")
