extends Node2D


var saves: Variant = null


func create_details():
	var label_str := ""
	label_str += "- Messages Sent: %d\n" % Saves.num_saves
	
	if saves["user_name"].is_empty():
		label_str += "- Your name: Undefined\n\n"
	else:
		label_str += "- Your name: %s\n\n" % saves["user_name"]
	
	if saves["webhook_url"].is_empty():
		label_str += "- Webhook: None\n"
	else:
		label_str += "- Webhook: Set\n"
	
	label_str += "- Webhook Name: %s\n" % saves["webhook_name"]
	
	if saves["webhook_avatar"] != "default":
		label_str += "- Webhook Avatar: Set\n"
	else:
		label_str += "- Webhook Avatar: default\n"
	
	$UILayer/Control/Header/Details.text = label_str


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Ready!")
	
	saves = Saves.Load()
	if not saves == null:
		print("There are settings that exist!")
		create_details()
		
		if (saves["user_name"].is_empty() || saves["user_name"] == null) || (saves["webhook_url"].is_empty() || saves["webhook_url"] == null):
			print("Critical details don't seem to be set...")
			$UILayer/Control/Send.disabled = true
	else:
		print("There are no settings that exist...")
		$UILayer/Control/Send.disabled = true


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Scenes/States/Settings.tscn")


func _on_send_pressed():
	if not saves == null:
		Saves.Save(
			saves["user_name"], 
			saves["webhook_name"], 
			saves["webhook_url"], 
			saves["webhook_avatar"]
		)
	
		Webhook.SendPayload(saves)
		
		create_details()

