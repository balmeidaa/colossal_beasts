extends Spatial



func _ready():
	var reader = CSVReader.new()
	var res = reader.load_file("res://assets/data_files/action_dat.csv")
	GameData.action_list = res

	#var pretty = JSON.print(res, "\t")
	#print(pretty)

