extends CanvasLayer

##enviarse a si mismo al game-handler
onready var player_q_ui = $HBox/Player
onready var opponent_q_ui = $HBox/Opponent

var mini_card = preload("res://assets/board/ui/CardMini.tscn")

const max_q_size = 5

var player_q = []
var opponent_q = []

func _ready():
	GameHandler.action_queue = self

func add_ui_action_Q(action_taken):
	var new_mini = mini_card.instance()
	## TO DO
	## * hacer distincion al agregar acciones del oponente en un futuro
	## * Agregar limite de acciones por cola
	## UI cambiar el orden de los minis
	player_q.append(action_taken)
	player_q_ui.add_child(new_mini)
	new_mini.load_mini(action_taken, player_q.size())
	player_q_ui.move_child(new_mini, 0) #solo para la cola de acciones del jugador, no de oponente

 
