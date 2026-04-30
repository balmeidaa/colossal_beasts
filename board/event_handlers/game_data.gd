extends Node

### IMAGENES ###
const action_icon_path  = 'res://assets/icons/%s.png'
const card_img_path = 'res://assets/beast_img/%s.jpg'
### Scripts ###
const scripts_path = 'res://board/action_scripts/%s.gd' ## scripts de acciones


##para la maquina de estados
enum States {IDLE, PRECOMBAT, TURN, POSTCOMBAT}

var card_list = {}
var action_list = {}
var buff_list = {}

func _ready():
	var reader = CSVReader.new()
	var res = reader.load_file("res://assets/data_files/action_cat.po")
	GameData.action_list = res
	res = reader.load_file("res://assets/data_files/card_cat.po")
	GameData.card_list = res
	res = reader.load_file("res://assets/data_files/buff_cat.po")
	GameData.buff_list = res
	
#	var pretty = JSON.print(GameData.action_list, "\t")
#	print(pretty)

func load_card_texture(filename):
	return GameData.card_img_path % filename

func load_action_texture(filename):
	return GameData.action_icon_path % filename

#solo para AI del juego para la cola de acciones de los minis
func load_action_icon_from_cat(action_name):
	var icon_name = action_list[action_name]['icon']
	return load_action_texture(icon_name)
