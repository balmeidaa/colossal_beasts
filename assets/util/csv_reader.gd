extends Node
class_name CSVReader

const id_key_index = 0

func load_file(file_path):    
	var file = File.new()
	file.open(file_path, file.READ)
	
	var dict = {}
	
	var keys = file.get_csv_line(",") #cabeceras
	var types = file.get_csv_line(",") #tipos de dato
	
	var lines = Array()
	
	while !file.eof_reached():
		var line = file.get_csv_line (",")
		if line.size() > 1:
			lines.append(line)
	file.close()
	
	for values in lines:
		
		var obj = {}
		var id_key = values[id_key_index]
		
		for index in range(1, keys.size()):
			var key = keys[index]
			var val = values[index]
			obj[key] = cast_values(val, types[index])
		
		dict[id_key] = obj
	
	return dict
	
#cast de tipos de var basicos		
func cast_values(value, type = 'string'):
	if value.empty() or type == 'string':
		return value
	
	match(type):
		"float":
			return float(value)
		"int":
			return int(value)
		"bool":
			if value == 'TRUE':
				return true
			return false
		"array":
			return cast_to_array(value)	

func cast_to_array(array_string):
	return array_string.replace(' ', '').split(',')
	
	
