extends Node


func SendPayload(saves: Variant):
	var msg = "%s is thinking about you!" % saves["user_name"]
	
	var embeds = [
		{
			"title": "Hey!",
			"description": msg,
			"color": 16239871
		}
	]
	
	var payload = {
		"embeds": embeds
	}
	
	if saves["webhook_avatar"] != "default":
		payload["avatar_url"] = saves["webhook_avatar"]
		
	if saves["webhook_name"] != "default":
		payload["username"] = saves["webhook_name"]
		
	var json_payload = JSON.stringify(payload)
	var error = $HTTPRequest.request(
		saves["webhook_url"],
		["Content-Type: application/json"],
		HTTPClient.Method.METHOD_POST,
		json_payload
	)
	
	if error != OK:
		print("Failed to complete http request")
	else:
		Saves.num_saves += 1



func _on_http_request_request_completed(result, _response_code, _headers, _body):
	if result != HTTPRequest.RESULT_SUCCESS:
		print("Failed to send request")
		return
