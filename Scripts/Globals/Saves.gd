extends Node

var num_saves

func Save(user_name: String, webhook_name: String, webhook_url: String, webhook_avatar: String):
	var save_model = {
		"user_name": user_name,
		
		"webhook_name": webhook_name,
		"webhook_avatar": webhook_avatar,
		"webhook_url": webhook_url,
		"num_sent": num_saves
	}
	
	var save_file = FileAccess.open("user://data.save", FileAccess.WRITE)
	var json = JSON.stringify(save_model)
	
	save_file.store_string(json)


func Load():
	if not FileAccess.file_exists("user://data.save"):
		num_saves = 0
		return null
	
	var data = FileAccess.open("user://data.save", FileAccess.READ)
	
	var parser = JSON.new()
	
	var is_error = parser.parse(data.get_as_text())
	assert(is_error == OK, "JSON Parse Error: %s at line %d" % [parser.get_error_message(), parser.get_error_line()])
	
	var save = parser.data
	num_saves = save["num_sent"]
	
	data.close()
	
	return save
