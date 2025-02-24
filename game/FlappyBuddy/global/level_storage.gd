extends Node

const level_path_root = "res://saved_levels/"
var name_to_save = "default"
var name_to_load = ""

func get_available_level() -> Array[String]:
	var file_names: Array[String] = []
	var dir = DirAccess.open(level_path_root)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				file_names.push_back(file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return file_names

func load_custom():
	if name_to_load.length() == 0:
		name_to_load = "default.json"
	var path = level_path_root + name_to_load
	var file = FileAccess.open(path, FileAccess.READ)
	var content_json = file.get_as_text()
	return JSON.parse_string(content_json)
	
func save_custom(level_data: String):
	if name_to_save.length() == 0:
		name_to_save = "default"
	var path = level_path_root +  name_to_save + ".json"
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(level_data)
	
