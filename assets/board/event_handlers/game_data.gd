extends Node

const action_icon_path  = 'res://assets/icons/%s.png'
const card_img_path = 'res://assets/beast_img/%s.jpg'


var card_list = {}
var action_list = {}

func _ready():
	var reader = CSVReader.new()
	## cambiar dat to cat
	var res = reader.load_file("res://assets/data_files/action_dat.po")
	GameData.action_list = res
	res = reader.load_file("res://assets/data_files/card_dat.po")
	GameData.card_list = res
	
#	var pretty = JSON.print(res, "\t")
#	print(res['raptor']['action_moveset'])

func load_card_texture(filename):
	return GameData.card_img_path % filename

func load_action_texture(filename):
	return GameData.action_icon_path % filename

#solo para AI del juego para la cola de acciones de los minis
func load_action_icon_from_cat(action_name):
	var icon_name = action_list[action_name]['icon']
	return load_action_texture(icon_name)
