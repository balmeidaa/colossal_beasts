extends Node
class_name CSVReader

const id_key_index = 0

func load_file(file_path):    
	var file = File.new()
	file.open(file_path, file.READ)
	
	var dict = {}
	
	var keys = file.get_csv_line(",")
	 
	#var types = file.get_csv_line(",") ## quizas se necesite despues
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
			obj[key] = val
		
		dict[id_key] = obj
	
	return dict
		
		
